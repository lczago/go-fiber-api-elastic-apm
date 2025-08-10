#!/bin/bash

# Script to stop the Docker Compose environment
echo "Stopping Docker Compose environment..."

# Stop the Docker Compose environment
docker compose down

echo "Docker Compose environment stopped successfully!"