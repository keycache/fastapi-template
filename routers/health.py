from typing import Dict

from fastapi import APIRouter, status

router = APIRouter()


@router.get("/health", response_model=Dict[str, str])
async def health_check():
    """
    Health check endpoint to verify the API is running
    """
    return {"status": "healthy"}
