#!/bin/bash
set -e

ENVIRONMENT=$1
INSTANCE_IP=$2

if [ -z "$ENVIRONMENT" ] || [ -z "$INSTANCE_IP" ]; then
    echo "Usage: $0 <environment> <instance_ip>"
    echo "Example: $0 staging 1.2.3.4"
    exit 1
fi

echo "Deploying backend to $ENVIRONMENT ($INSTANCE_IP)..."

# Build backend
cd backend
npm ci --production
npm run build

# Create deployment package
tar -czf ../backend-deploy.tar.gz dist/ package.json package-lock.json

# Deploy to server
scp -i ~/.ssh/cvhere-${ENVIRONMENT}-key.pem ../backend-deploy.tar.gz ec2-user@${INSTANCE_IP}:/tmp/
ssh -i ~/.ssh/cvhere-${ENVIRONMENT}-key.pem ec2-user@${INSTANCE_IP} << 'EOF'
    # Stop existing service
    sudo pkill -f "node.*server.js" || true
    
    # Extract new version
    cd /opt/cvhere
    sudo rm -rf backend
    sudo mkdir -p backend
    cd backend
    sudo tar -xzf /tmp/backend-deploy.tar.gz
    
    # Install dependencies and start
    sudo npm ci --production
    sudo nohup node dist/server.js > /var/log/cvhere-backend.log 2>&1 &
    
    echo "Backend deployed successfully"
EOF

rm ../backend-deploy.tar.gz
echo "Backend deployment complete"