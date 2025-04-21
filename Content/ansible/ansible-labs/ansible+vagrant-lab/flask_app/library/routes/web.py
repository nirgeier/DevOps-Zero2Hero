from flask import Blueprint, render_template, request, redirect, url_for, flash
from flask_app.library.db import get_db

bp = Blueprint('web', __name__)

@bp.route('/')
def index():
    db = get_db()
    books = db.books.find()
    return render_template('index.html', books=books)

@bp.route('/add', methods=['GET','POST'])
def add_book():
    if request.method == 'POST':
        title  = request.form.get('title','').strip()
        author = request.form.get('author','').strip()
        status = request.form.get('status','available')
        if not title or not author:
            flash('Title and Author are required.', 'danger')
            return render_template('add_book.html', form=request.form)

        db = get_db()
        db.books.insert_one({
            'title':  title,
            'author': author,
            'status': status
        })
        flash(f'Book "{title}" added!', 'success')
        return redirect(url_for('web.index'))

    # GET
    return render_template('add_book.html')
