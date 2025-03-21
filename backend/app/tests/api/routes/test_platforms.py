import pytest
from fastapi.testclient import TestClient
from sqlmodel import Session

from app.models import Platform, PlatformCreate, PlatformUpdate
from app.tests.utils.utils import random_lower_string
from app.core.config import settings


@pytest.fixture
def platform_data():
    return {"name": random_lower_string()}


def test_create_platform(client: TestClient, superuser_token_headers: dict[str, str], platform_data: dict):
    response = client.post(
        f"{settings.API_V1_STR}/platforms/",
        headers=superuser_token_headers,
        json=platform_data,
    )
    assert response.status_code == 200
    content = response.json()
    assert content["name"] == platform_data["name"]
    assert "id" in content


def test_update_platform(client: TestClient, superuser_token_headers: dict[str, str], db: Session, platform_data: dict):
    platform = Platform(name=platform_data["name"])
    db.add(platform)
    db.commit()
    db.refresh(platform)

    update_data = {"name": random_lower_string()}
    response = client.put(
        f"{settings.API_V1_STR}/platforms/{platform.id}",
        headers=superuser_token_headers,
        json=update_data,
    )
    assert response.status_code == 200
    content = response.json()
    assert content["name"] == update_data["name"]
    assert content["id"] == platform.id


def test_delete_platform(client: TestClient, superuser_token_headers: dict[str, str], db: Session, platform_data: dict):
    platform = Platform(name=platform_data["name"])
    db.add(platform)
    db.commit()
    db.refresh(platform)

    response = client.delete(
        f"{settings.API_V1_STR}/platforms/{platform.id}",
        headers=superuser_token_headers,
    )
    assert response.status_code == 200
    content = response.json()
    assert content["message"] == "Platform deleted successfully"


def test_list_platforms(client: TestClient, superuser_token_headers: dict[str, str], db: Session, platform_data: dict):
    platform = Platform(name=platform_data["name"])
    db.add(platform)
    db.commit()
    db.refresh(platform)

    response = client.get(
        f"{settings.API_V1_STR}/platforms/",
        headers=superuser_token_headers,
    )
    assert response.status_code == 200
    content = response.json()
    assert len(content["data"]) > 0
    assert any(p["id"] == platform.id for p in content["data"])
