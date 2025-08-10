#!/bin/bash

echo "Starting Docker Compose environment..."

# Make sure the elasticsearch data directory exists and all files have proper permissions
mkdir -p ./elasticsearch_data
chmod 777 ./elasticsearch_data
chmod 644 ./beats/metric/metricbeat.yml
chmod 644 ./beats/heartbeat/heartbeat.yml
chmod 644 ./apm/apm-server.yml

# Start Docker Compose
docker compose up -d

echo "Docker Compose environment started successfully!"
echo "  - Go API generate error: http://localhost:8080/error"
echo "  - Kibana trace: http://localhost:5601/app/apm/traces"
echo "  wait till error tracing is flushed to the server - refresh kibana trace dashboard if needed"
