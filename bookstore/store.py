from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)
from werkzeug.exceptions import abort

from bookstore.auth import login_required
from bookstore.db import get_db

bp = Blueprint('store', __name__)

@bp.route('/')
def index():
    db = get_db()
    books = db.execute(
        'SELECT b.book_id, b.title, b.isbn, b.publication_year, a.author_name, b.price, b.stock_quantity '
        'FROM books b JOIN authors a ON b.author_id = a.author_id'
        ' ORDER BY publication_year DESC'
    ).fetchall()
    return render_template('store/index.html', books=books)


@bp.route('/create', methods=('GET', 'POST'))
@login_required
def create():
    if request.method == 'POST':
        title = request.form['title']
        isbn = request.form['isbn']
        publication_year = request.form['publication_year']
        author_id = request.form['author_id']
        genre_id = request.form['genre_id']
        publisher_id = request.form['publisher_id']
        price = request.form['price']
        stock_quantity = request.form['stock_quantity']
        
        error = None

        if not title:
            error = 'Title is required.'

        # Add additional validation as needed for other fields

        if error is not None:
            flash(error)
        else:
            db = get_db()
            db.execute(
                'INSERT INTO books (title, isbn, publication_year, author_id, genre_id, publisher_id, price, stock_quantity)'
                ' VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
                (title, isbn, publication_year, author_id, genre_id, publisher_id, price, stock_quantity)
            )
            db.commit()
            return redirect(url_for('book.index'))

    # Fetch authors, genres, publishers for dropdowns
    db = get_db()
    authors = db.execute('SELECT * FROM authors').fetchall()
    genres = db.execute('SELECT * FROM genres').fetchall()
    publishers = db.execute('SELECT * FROM publishers').fetchall()

    return render_template('store/create.html', authors=authors, genres=genres, publishers=publishers)

def get_book(book_id, check_author=True):
    book = get_db().execute(
        'SELECT b.book_id, title, isbn, publication_year, author_id, genre_id, publisher_id, price, stock_quantity, author_name, genre_name, publisher_name'
        ' FROM books b JOIN authors a ON b.author_id = a.author_id'
        ' JOIN genres g ON b.genre_id = g.genre_id'
        ' JOIN publishers p ON b.publisher_id = p.publisher_id'
        ' WHERE b.book_id = ?',
        (book_id,)
    ).fetchone()

    if book is None:
        abort(404, f"Book id {book_id} doesn't exist.")

    if check_author and book['author_id'] != g.user['id']:
        abort(403)

    return book

@bp.route('/<int:book_id>/update', methods=('GET', 'POST'))
@login_required
def update(book_id):
    book = get_book(book_id)

    if request.method == 'POST':
        title = request.form['title']
        isbn = request.form['isbn']
        publication_year = request.form['publication_year']
        author_id = request.form['author_id']
        genre_id = request.form['genre_id']
        publisher_id = request.form['publisher_id']
        price = request.form['price']
        stock_quantity = request.form['stock_quantity']

        error = None

        if not title:
            error = 'Title is required.'

        # Add additional validation as needed for other fields

        if error is not None:
            flash(error)
        else:
            db = get_db()
            db.execute(
                'UPDATE books SET title = ?, isbn = ?, publication_year = ?,'
                ' author_id = ?, genre_id = ?, publisher_id = ?, price = ?, stock_quantity = ?'
                ' WHERE book_id = ?',
                (title, isbn, publication_year, author_id, genre_id, publisher_id, price, stock_quantity, book_id)
            )
            db.commit()
            return redirect(url_for('book.index'))

    # Fetch authors, genres, publishers for dropdowns
    db = get_db()
    authors = db.execute('SELECT * FROM authors').fetchall()
    genres = db.execute('SELECT * FROM genres').fetchall()
    publishers = db.execute('SELECT * FROM publishers').fetchall()

    return render_template('book/update.html', book=book, authors=authors, genres=genres, publishers=publishers)

@bp.route('/<int:book_id>/delete', methods=('POST',))
@login_required
def delete(book_id):
    get_book(book_id)
    db = get_db()
    db.execute('DELETE FROM books WHERE book_id = ?', (book_id,))
    db.commit()
    return redirect(url_for('book.index'))