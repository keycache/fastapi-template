from fastapi import FastAPI

from routers import health

app = FastAPI(
    title="FastAPI Template", description="A template FastAPI project with health check endpoints", version="1.0.0"
)

# Include routers
app.include_router(health.router, tags=["Health"])

if __name__ == "__main__":
    import uvicorn

    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
