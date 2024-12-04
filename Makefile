.PHONY: build run test-unit test-integration clean format format-check db-migrate db-upgrade

# Variables
APP_NAME = fastapi-template
TEST_IMAGE = $(APP_NAME)-test
PORT = 8000

# Build the main application image
build:
	docker build -t $(APP_NAME) .

# Run the application locally
run: build
	docker run -d --name $(APP_NAME)-app -p $(PORT):$(PORT) $(APP_NAME)
	@echo "Application is running at http://localhost:$(PORT)"
	@echo "To view logs: docker logs -f $(APP_NAME)-app"

# Build test image
build-test:
	docker build -t $(TEST_IMAGE) -f Dockerfile.test .

# Run unit tests in a container
test-unit: build-test
	docker run --rm $(TEST_IMAGE) pytest tests/unit -v

# Run integration tests in a container
test-integration: build-test
	docker run --rm --network host $(TEST_IMAGE) pytest tests/integration -v

# Format code using ruff
format:
	docker run --rm -v $(PWD):/app $(TEST_IMAGE) ruff check --select I --fix .
	docker run --rm -v $(PWD):/app $(TEST_IMAGE) ruff format .

# Check code formatting without making changes
format-check:
	docker run --rm -v $(PWD):/app $(TEST_IMAGE) ruff format --check .

# Database migrations
db-new-migration:
	docker run --rm -v $(PWD):/app $(TEST_IMAGE) alembic revision --autogenerate -m "$(message)"

# Apply database migrations
db-upgrade:
	docker run --rm -v $(PWD):/app $(TEST_IMAGE) alembic upgrade head

# Clean up containers and images
clean:
	-docker stop $(APP_NAME)-app 2>/dev/null || true
	-docker rm $(APP_NAME)-app 2>/dev/null || true
	-docker rmi $(APP_NAME) $(TEST_IMAGE) 2>/dev/null || true

# Help target
help:
	@echo "Available targets:"
	@echo "  build            	- Build the main application Docker image"
	@echo "  run             	- Run the application locally in a container"
	@echo "  test-unit       	- Run unit tests in a container"
	@echo "  test-integration 	- Run integration tests in a container"
	@echo "  format          	- Format code using ruff"
	@echo "  format-check    	- Check code formatting without making changes"
	@echo "  db-new-migration   - Create a new database migration (use with message='Migration message')"
	@echo "  db-upgrade      	- Apply all pending database migrations"
	@echo "  clean           	- Remove containers and images"
	@echo "  help            	- Show this help message"
