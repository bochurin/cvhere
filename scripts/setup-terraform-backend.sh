#!/bin/bash
set -e

echo "Setting up Terraform S3 backend..."

# Create S3 bucket for Terraform state
aws s3 mb s3://cvhere-terraform-state --region us-east-1

# Enable versioning
aws s3api put-bucket-versioning \
    --bucket cvhere-terraform-state \
    --versioning-configuration Status=Enabled

# Create DynamoDB table for state locking
aws dynamodb create-table \
    --table-name cvhere-terraform-locks \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region us-east-1

echo "✅ Terraform backend setup complete"
echo "S3 bucket: cvhere-terraform-state"
echo "DynamoDB table: cvhere-terraform-locks"