from flask import Flask
from .config import settings
from .db import init_db
from .routes.web import web_bp
from .routes.api import api_bp

def create_app():
    app = Flask(__name__)
    app.config.from_object(settings)

    init_db(app)          # attach PyMongo client
    app.register_blueprint(web_bp)
    app.register_blueprint(api_bp, url_prefix="/api/v1")

    if settings.ENABLE_AUTH:
        from .auth import auth_bp
        app.register_blueprint(auth_bp)

    return app

# gunicorn will import "library:create_app"
