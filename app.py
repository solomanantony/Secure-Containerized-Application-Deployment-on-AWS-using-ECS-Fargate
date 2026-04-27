from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "Secure Cloud App Running"

@app.route("/health")
def health():
    return "OK"

@app.route("/info")
def info():
    return "Container Security Project"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)