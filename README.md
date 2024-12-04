# FastAPI Template

A template project for FastAPI applications with health check endpoints and testing setup.

## Features

- Health check endpoint
- Modular router structure
- Unit and integration tests
- Clean project structure

## Installation

1. Create a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: .\venv\Scripts\activate
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

## Running the Application

```bash
python main.py
```

Or using uvicorn directly:
```bash
uvicorn main:app --reload
```

The application will be available at http://localhost:8000

## API Documentation

Once running, you can access:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

## Running Tests

Run unit tests:
```bash
pytest tests/test_health.py -v
```

Run integration tests (ensure the server is running first):
```bash
pytest tests/integration/test_health_integration.py -v
```

## Using Make Commands

The project includes a Makefile for easy management of Docker operations:

```bash
# Build the application image
make build

# Run the application locally
make run

# Run unit tests in a container
make test-unit

# Run integration tests in a container
make test-integration

# Clean up containers and images
make clean

# Show all available commands
make help
```

## Code Formatting

This project uses `ruff` for code formatting, following the Black code style. To format your code:

```bash
# Format all Python files
make format

# Check formatting without making changes
make format-check
```

The formatting rules are configured in `ruff.toml` and follow the Black code style guidelines.

## Docker Support

### Building the Docker Image

```bash
docker build -t fastapi-template .
```

### Running the Container

```bash
docker run -d -p 8000:8000 --name fastapi-app fastapi-template
```

The application will be available at http://localhost:8000

### Docker Commands

- Stop the container:
```bash
docker stop fastapi-app
```

- Remove the container:
```bash
docker rm fastapi-app
```

- View container logs:
```bash
docker logs fastapi-app
```
