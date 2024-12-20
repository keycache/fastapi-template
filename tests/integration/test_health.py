import pytest
import httpx

from config import get_settings

settings = get_settings()

# Update this URL based on your deployment environment
BASE_URL = "http://api:8000"


@pytest.mark.asyncio
async def test_health_check_integration():
    """
    Integration test for health check endpoint
    """
    async with httpx.AsyncClient() as client:
        response = await client.get(f"{BASE_URL}{settings.API_V1_STR}/health")
        assert response.status_code == 200
        assert response.json() == {"status": "healthy"}
