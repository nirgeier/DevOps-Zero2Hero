from flask import Blueprint, jsonify, request
from ..db import mongo
from ..models import Book

api_bp = Blueprint("api", __name__)

@api_bp.get("/books")
def list_books():
    docs = mongo.db.books.find()
    return jsonify([Book(**b).dict() for b in docs])

@api_bp.post("/books")
def add_book():
    payload = Book(**request.json)
    _id = mongo.db.books.insert_one(payload.dict(by_alias=True, exclude={"id"})).inserted_id
    payload.id = str(_id)
    return jsonify(payload.dict()), 201
