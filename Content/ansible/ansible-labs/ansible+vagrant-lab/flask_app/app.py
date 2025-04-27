import os
from flask import Flask, jsonify, request, render_template
from pymongo import MongoClient
from bson.objectid import ObjectId

app = Flask(__name__)

# honor the ANSIBLE-populated var or default:
MONGO_URI = os.environ.get('MONGO_URI') or "mongodb://localhost:27017/projectdb"
client = MongoClient(MONGO_URI)
db     = client.get_default_database()
books  = db.books

# seed data if empty
if books.count_documents({}) == 0:
    books.insert_many([
        {'title': '1984',               'author': 'George Orwell',     'status': 'available'},
        {'title': 'Brave New World',    'author': 'Aldous Huxley',     'status': 'available'},
    ])

@app.route('/')
def home():
    allb = list(books.find())
    for b in allb:
        b['id'] = str(b['_id'])
    return render_template('index.html', books=allb)

@app.route('/api/v1/books', methods=['GET'])
def list_books():
    allb = list(books.find())
    out  = []
    for b in allb:
        out.append({
            'id':     str(b['_id']),
            'title':  b['title'],
            'author': b['author'],
            'status': b.get('status','unknown')
        })
    return jsonify(out)

@app.route('/api/v1/books/<book_id>', methods=['GET'])
def book_status(book_id):
    b = books.find_one({'_id': ObjectId(book_id)})
    if not b:
        return jsonify({'error':'not found'}), 404
    return jsonify({'status': b.get('status','unknown')})

@app.route('/api/v1/books', methods=['POST'])
def add_book():
    data   = request.get_json() or {}
    title  = data.get('title')
    author = data.get('author')
    status = data.get('status','available')
    if not title or not author:
        return jsonify({'error':'title+author required'}), 400
    res = books.insert_one({'title': title,'author': author,'status': status})
    return jsonify({'id': str(res.inserted_id)}), 201

if __name__ == '__main__':
    port = int(os.environ.get('FLASK_PORT', 5000))
    app.run(host='0.0.0.0', port=port)
