from flask import Flask, jsonify
import os, time

app = Flask(__name__)

@app.get("/healthz")
def healthz():
    return jsonify(status="ok", ts=time.time()), 200

# TODO: register blueprints here (auth, api, etc.)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("PORT", "10000")))