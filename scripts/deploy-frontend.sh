#!/bin/bash
set -e

ENVIRONMENT=$1
INSTANCE_IP=$2

if [ -z "$ENVIRONMENT" ] || [ -z "$INSTANCE_IP" ]; then
    echo "Usage: $0 <environment> <instance_ip>"
    echo "Example: $0 staging 1.2.3.4"
    exit 1
fi

echo "Deploying frontend to $ENVIRONMENT ($INSTANCE_IP)..."

# Build frontend
cd frontend
npm ci
npm run build

# Inject environment config
if [ "$ENVIRONMENT" = "staging" ]; then
    echo "backendUrl: https://api-staging.cvhere.net" > dist/config.yaml
elif [ "$ENVIRONMENT" = "production" ]; then
    echo "backendUrl: https://api.cvhere.net" > dist/config.yaml
fi

# Create deployment package
tar -czf ../frontend-deploy.tar.gz dist/

# Deploy to server
scp -i ~/.ssh/cvhere-${ENVIRONMENT}-key.pem ../frontend-deploy.tar.gz ec2-user@${INSTANCE_IP}:/tmp/
ssh -i ~/.ssh/cvhere-${ENVIRONMENT}-key.pem ec2-user@${INSTANCE_IP} << 'EOF'
    # Stop existing service
    sudo pkill -f "serve" || true
    
    # Extract new version
    cd /opt/cvhere
    sudo rm -rf frontend
    sudo mkdir -p frontend
    cd frontend
    sudo tar -xzf /tmp/frontend-deploy.tar.gz
    
    # Start frontend server
    sudo nohup npx serve dist -l 3000 > /var/log/cvhere-frontend.log 2>&1 &
    
    echo "Frontend deployed successfully"
EOF

rm ../frontend-deploy.tar.gz
echo "Frontend deployment complete"