#!/bin/bash

echo "Starting Docker Compose environment..."

# Make sure the elasticsearch data directory exists with proper permissions
mkdir -p ./elasticsearch_data
chmod 777 ./elasticsearch_data

# Start Docker Compose
docker compose up -d

echo "Docker Compose environment started successfully!"
echo "  - Go API generate error: http://localhost:8080/error"
echo "  - Kibana trace: http://localhost:5601/app/apm/traces"
