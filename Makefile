.PHONY: build run test-unit test-integration clean

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

# Clean up containers and images
clean:
	-docker stop $(APP_NAME)-app 2>/dev/null || true
	-docker rm $(APP_NAME)-app 2>/dev/null || true
	-docker rmi $(APP_NAME) $(TEST_IMAGE) 2>/dev/null || true

# Help target
help:
	@echo "Available targets:"
	@echo "  build            - Build the main application Docker image"
	@echo "  run             - Run the application locally in a container"
	@echo "  test-unit       - Run unit tests in a container"
	@echo "  test-integration - Run integration tests in a container"
	@echo "  clean           - Remove containers and images"
	@echo "  help            - Show this help message"
