from flask import Flask
from dotenv import load_dotenv
import os
import logging

from backend.db_connection import init_app as init_db
from backend.users.user_routes import users
from backend.reports.report_routes import reports
from backend.locations_tickets.routes import locations_tickets
from backend.analytics.analytics_routes import analytics


def create_app():
    app = Flask(__name__)

    app.logger.setLevel(logging.DEBUG)
    app.logger.info('API startup')

    load_dotenv()

    app.config["SECRET_KEY"] = os.getenv("SECRET_KEY")

    app.config["MYSQL_DATABASE_USER"] = os.getenv("DB_USER").strip()
    app.config["MYSQL_DATABASE_PASSWORD"] = os.getenv("MYSQL_ROOT_PASSWORD").strip()
    app.config["MYSQL_DATABASE_HOST"] = os.getenv("DB_HOST").strip()
    app.config["MYSQL_DATABASE_PORT"] = int(os.getenv("DB_PORT").strip())
    app.config["MYSQL_DATABASE_DB"] = os.getenv("DB_NAME").strip()

    app.logger.info("create_app(): initializing database connection")
    init_db(app)

    app.logger.info("create_app(): registering blueprints")
    app.register_blueprint(users, url_prefix="/users")
    app.register_blueprint(reports, url_prefix="/reports")
    app.register_blueprint(locations_tickets)
    app.register_blueprint(analytics, url_prefix="/analytics")

    return app
