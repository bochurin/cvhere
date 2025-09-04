#!/bin/bash
# Get server IP from Terraform

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
    echo "Usage: ./get-server-ip.sh <environment>"
    echo "Example: ./get-server-ip.sh staging"
    exit 1
fi

echo "🔍 Getting $ENVIRONMENT server IP..."

cd terraform
terraform output -raw server_ip