from fastapi import FastAPI

from config import get_settings
from routers import health

settings = get_settings()

app = FastAPI(
    title="FastAPI Template", description="A template FastAPI project with health check endpoints", version="1.0.0"
)

# Include routers with API version prefix
app.include_router(health.router, prefix=settings.API_V1_STR, tags=["Health"])

if __name__ == "__main__":
    import uvicorn

    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
