# app.py
from flask import Flask
from flask_cors import CORS
from extensions import db
from routes import main_bp
from utils import refresh_idiom_cache
import os
from dotenv import load_dotenv
from utils import refresh_idiom_cache, datetimeformat
import socket

def getaddrinfo_ipv4(host, port, family=0, type=0, proto=0, flags=0):
    return socket.orig_getaddrinfo(host, port, socket.AF_INET, type, proto, flags)

socket.orig_getaddrinfo = socket.getaddrinfo
socket.getaddrinfo = getaddrinfo_ipv4

load_dotenv()

def create_app():
    app = Flask(__name__)
    CORS(app, supports_credentials=True)

    # Configuration
    app.secret_key = os.getenv("FLASK_SECRET", "dev_secret")
    database_url = os.getenv('DATABASE_URL', 'mysql+pymysql://root:Abhi%402004@localhost/kannada_db?charset=utf8mb4')
    
    # If the URL from Render starts with "mysql://", replace it with "mysql+pymysql://"
    if database_url and database_url.startswith("mysql://"):
        database_url = database_url.replace("mysql://", "mysql+pymysql://", 1)
        
    app.config['SQLALCHEMY_DATABASE_URI'] = database_url    
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    # Initialize Extensions
    db.init_app(app)
    app.add_template_filter(datetimeformat) 
    app.register_blueprint(main_bp)

    with app.app_context():
        db.create_all()
        refresh_idiom_cache()
 
    return app

if __name__ == "__main__":
    app = create_app()
    app.run(debug=True, host="0.0.0.0", port=5000)