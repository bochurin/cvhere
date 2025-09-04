#!/bin/bash
set -e

ENVIRONMENT=$1
INSTANCE_IP=$2

if [ -z "$ENVIRONMENT" ] || [ -z "$INSTANCE_IP" ]; then
    echo "Usage: $0 <environment> <instance_ip>"
    echo "Example: $0 staging 1.2.3.4"
    exit 1
fi

echo "Running health checks for $ENVIRONMENT ($INSTANCE_IP)..."

# Check backend health
echo "Checking backend health..."
BACKEND_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://${INSTANCE_IP}:3001/health || echo "000")
if [ "$BACKEND_RESPONSE" = "200" ]; then
    echo "✅ Backend health check passed"
else
    echo "❌ Backend health check failed (HTTP $BACKEND_RESPONSE)"
    exit 1
fi

# Check frontend
echo "Checking frontend..."
FRONTEND_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://${INSTANCE_IP}:3000 || echo "000")
if [ "$FRONTEND_RESPONSE" = "200" ]; then
    echo "✅ Frontend health check passed"
else
    echo "❌ Frontend health check failed (HTTP $FRONTEND_RESPONSE)"
    exit 1
fi

echo "🎉 All health checks passed for $ENVIRONMENT"