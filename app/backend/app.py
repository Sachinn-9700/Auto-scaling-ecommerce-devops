from flask import Flask, jsonify, request
import time
import random
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)

# ------------------------
# Prometheus Metrics
# ------------------------

REQUEST_COUNT = Counter(
    "http_requests_total",
    "Total HTTP requests",
    ["method", "endpoint", "status"]
)

REQUEST_LATENCY = Histogram(
    "http_request_duration_seconds",
    "HTTP request latency",
    ["endpoint"]
)

APP_INFO = Counter(
    "app_info",
    "Application info",
    ["app_name"]
)

APP_INFO.labels(app_name="auto-scaling-ecommerce-backend").inc()

# ------------------------
# Fake in-memory DB
# ------------------------

PRODUCTS = [
    {
        "id": "p1",
        "name": "Wireless Headphones",
        "description": "Noise cancelling over-ear headphones",
        "price": 2999
    },
    {
        "id": "p2",
        "name": "Smart Watch",
        "description": "Fitness tracking smart watch",
        "price": 4999
    },
    {
        "id": "p3",
        "name": "Gaming Mouse",
        "description": "High precision RGB gaming mouse",
        "price": 1599
    },
    {
        "id": "p4",
        "name": "Mechanical Keyboard",
        "description": "Blue switch mechanical keyboard",
        "price": 3499
    }
]

# ------------------------
# Routes
# ------------------------

@app.route("/health", methods=["GET"])
def health():
    REQUEST_COUNT.labels("GET", "/health", 200).inc()
    return jsonify({"status": "UP"}), 200


@app.route("/api/products", methods=["GET"])
@REQUEST_LATENCY.labels("/api/products").time()
def get_products():
    burn_cpu()
    REQUEST_COUNT.labels("GET", "/api/products", 200).inc()
    return jsonify(PRODUCTS), 200


@app.route("/api/cart", methods=["POST"])
@REQUEST_LATENCY.labels("/api/cart").time()
def add_to_cart():
    data = request.get_json()
    burn_cpu()
    REQUEST_COUNT.labels("POST", "/api/cart", 201).inc()
    return jsonify({
        "message": "Product added to cart",
        "product_id": data.get("product_id")
    }), 201


# ------------------------
# Prometheus endpoint
# ------------------------

@app.route("/metrics")
def metrics():
    return generate_latest(), 200, {"Content-Type": CONTENT_TYPE_LATEST}


# ------------------------
# CPU burn (HPA demo)
# ------------------------

def burn_cpu():
    x = 0
    for i in range(10_000_00):
        x += random.random()
    time.sleep(0.1)


# ------------------------
# Main
# ------------------------

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
# To run the app: gunicorn -w 4 -b