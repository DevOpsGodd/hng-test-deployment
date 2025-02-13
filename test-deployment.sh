#!/bin/bash

echo "=== Testing Deployment Process ==="

# 1. Stop any running containers
echo "Stopping existing containers..."
docker-compose down

# 2. Clean up Docker cache
echo "Cleaning Docker cache..."
docker system prune -f

# 3. Build fresh images
echo "Building fresh images..."
docker-compose build --no-cache

# 4. Start services
echo "Starting services..."
docker-compose up -d

# 5. Wait for services to be ready
echo "Waiting for services to start..."
sleep 10

# 6. Test endpoints
echo "Testing endpoints..."
echo "Testing /healthcheck endpoint..."
curl -s http://localhost/healthcheck

echo "Testing /stage2 endpoint..."
curl -s http://localhost/stage2

echo "Testing /api/v1/books/1 endpoint..."
curl -s http://localhost/api/v1/books/1

# 7. Check container logs
echo "Checking container logs..."
docker-compose logs
