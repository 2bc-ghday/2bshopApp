import uuid
from fastapi.testclient import TestClient
from app.main import app
from sqlmodel import Session, create_engine, SQLModel
from app.models import Compliance

# Setup test database
DATABASE_URL = "sqlite:///./test.db"
engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SQLModel.metadata.create_all(engine)

client = TestClient(app)

def test_create_compliance():
    response = client.post("/api/v1/compliances1", json={"name": "Test Compliance"})
    assert response.status_code == 200
    data = response.json()
    assert data["name"] == "Test Compliance"
    assert "id" in data

def test_list_compliances():
    response = client.get("/api/v1/compliances")
    assert response.status_code == 200
    data = response.json()
    assert isinstance(data, list)
    assert len(data) > 0

def test_delete_compliance():
    # Create a compliance to delete
    response = client.post("/api/v1/compliances", json={"name": "Compliance to Delete"})
    compliance_id = response.json()["id"]

    # Delete the compliance
    delete_response = client.delete(f"/api/v1/compliances/{compliance_id}")
    assert delete_response.status_code == 200
    assert delete_response.json()["message"] == "Compliance deleted successfully"