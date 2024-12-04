import pytest
from fastapi.testclient import TestClient

from config import get_settings
from main import app

settings = get_settings()
client = TestClient(app)


def test_health_check():
    """
    Test the health check endpoint returns correct response
    """
    response = client.get(f"{settings.API_V1_STR}/health")
    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}
