from flask import Flask, render_template, request
from pymongo import MongoClient
import os

app = Flask(__name__)

mongo_uri = os.getenv('MONGO_URI', 'mongodb://localhost:27017/')
client = MongoClient(mongo_uri)
db = client['projectdb']
books_col = db['books']

@app.route('/', methods=['GET'])
def index():
    qry = {}
    search = request.args.get('search')
    status = request.args.get('status')
    genre  = request.args.get('genre')

    if search:
        qry['title'] = {'$regex': search, '$options': 'i'}
    if status:
        qry['status'] = status
    if genre:
        qry['genre'] = genre

    books  = list(books_col.find(qry))
    genres = books_col.distinct('genre')

    return render_template('index.html',
                           books=books,
                           genres=genres,
                           selected={'search': search, 'status': status, 'genre': genre})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
