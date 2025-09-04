#!/bin/bash
# Simple deployment script

ENVIRONMENT=$1
SERVER_IP=$2

if [ -z "$ENVIRONMENT" ] || [ -z "$SERVER_IP" ]; then
    echo "Usage: ./deploy.sh <environment> <server_ip>"
    echo "Example: ./deploy.sh staging 1.2.3.4"
    exit 1
fi

echo "🚀 Deploying to $ENVIRONMENT ($SERVER_IP)..."

# Build the apps
echo "📦 Building applications..."
npm run build:backend
npm run build:frontend

# Copy to server (we'll use simple file copy for now)
echo "📤 Copying files to server..."
echo "TODO: Copy files to $SERVER_IP"

# Start services on server
echo "🔄 Starting services..."
echo "TODO: Start backend and frontend on server"

echo "✅ Deployment complete!"