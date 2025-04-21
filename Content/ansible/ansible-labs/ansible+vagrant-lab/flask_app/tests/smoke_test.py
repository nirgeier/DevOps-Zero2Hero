import os, pytest
from library import create_app

@pytest.fixture
def client():
    os.environ["MONGO_URI"] = "mongodb://192.168.56.12:27017/projectdb"
    app = create_app()
    return app.test_client()

def test_health(client):
    r = client.get("/api/v1/books")
    assert r.status_code == 200
