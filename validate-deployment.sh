#!/bin/bash

# Step 1: Build and start the containers
echo "Starting deployment validation..."
docker-compose down
docker system prune -af  # Clear all cached images
docker-compose up -d --build

# Step 2: Wait for services to start
echo "Waiting for services to start..."
sleep 10

# Step 3: Test the endpoints
echo "Testing endpoints..."

# Test healthcheck
HEALTH_CHECK=$(curl -s http://localhost/healthcheck)
echo "Healthcheck response: $HEALTH_CHECK"

# Test book endpoint
BOOK_RESPONSE=$(curl -s http://localhost/api/v1/books/1)
echo "Book endpoint response: $BOOK_RESPONSE"

# Test stage2 endpoint (we'll add this temporarily for testing)
STAGE2_RESPONSE=$(curl -s http://localhost/stage2)
echo "Stage2 endpoint response: $STAGE2_RESPONSE"

# Check container logs
echo "Checking container logs..."
docker-compose logs app
docker-compose logs nginx
