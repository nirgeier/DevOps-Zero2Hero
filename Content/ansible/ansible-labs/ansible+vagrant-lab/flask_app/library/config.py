import os

class Settings:
    MONGO_URI = os.getenv("MONGO_URI", "mongodb://localhost:27017/projectdb")
    SECRET_KEY = os.getenv("SECRET_KEY", "dev")
    ENABLE_AUTH = os.getenv("ENABLE_AUTH", "false").lower() == "true"

settings = Settings()
