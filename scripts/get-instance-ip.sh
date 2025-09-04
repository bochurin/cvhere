#!/bin/bash
set -e

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
    echo "Usage: $0 <environment>"
    echo "Example: $0 staging"
    exit 1
fi

echo "Getting EC2 instance IP for $ENVIRONMENT..."

cd terraform
terraform output -raw ${ENVIRONMENT}_instance_ip