from flask import Flask, jsonify, request
import time
import random
import os

app = Flask(__name__)

# Fake in-memory product DB (stateless)
PRODUCTS = [
    {
        "id": "p1",
        "name": "Wireless Headphones",
        "description": "Noise cancelling over-ear headphones",
        "price": 2999,
        "image": "https://via.placeholder.com/300x200?text=Headphones"
    },
    {
        "id": "p2",
        "name": "Smart Watch",
        "description": "Fitness tracking smart watch",
        "price": 4999,
        "image": "https://via.placeholder.com/300x200?text=Smart+Watch"
    },
    {
        "id": "p3",
        "name": "Gaming Mouse",
        "description": "High precision RGB gaming mouse",
        "price": 1599,
        "image": "https://via.placeholder.com/300x200?text=Mouse"
    },
    {
        "id": "p4",
        "name": "Mechanical Keyboard",
        "description": "Blue switch mechanical keyboard",
        "price": 3499,
        "image": "https://via.placeholder.com/300x200?text=Keyboard"
    }
]

@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "UP"}), 200


@app.route("/api/products", methods=["GET"])
def get_products():
    # simulate CPU load (for HPA demo)
    burn_cpu()

    return jsonify(PRODUCTS), 200


@app.route("/api/cart", methods=["POST"])
def add_to_cart():
    data = request.get_json()
    product_id = data.get("product_id")

    burn_cpu()

    return jsonify({
        "message": "Product added to cart",
        "product_id": product_id
    }), 201


def burn_cpu():
    """
    Artificial CPU usage to trigger
    """
    