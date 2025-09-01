# Deployment Guide

## Prerequisites

1. **AWS Account** with appropriate permissions
2. **GitHub Secrets** configured:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
3. **SSH Key Pairs** created in AWS:
   - `cvhere-staging-key`
   - `cvhere-production-key`

## Initial Setup

### 1. Create Terraform Backend
```bash
# Run once to create S3 bucket and DynamoDB table for Terraform state
./scripts/setup-terraform-backend.sh
```

### 2. Deploy Infrastructure
```bash
# Deploy staging infrastructure
cd terraform
terraform init
terraform plan -var-file="staging.tfvars"
terraform apply -var-file="staging.tfvars"

# Deploy production infrastructure (when ready)
terraform plan -var-file="production.tfvars"
terraform apply -var-file="production.tfvars"
```

## Deployment Workflow

### Automatic Deployments

- **Staging**: Triggered on push to `develop` branch
- **Production**: Triggered on git tags (e.g., `v1.0.0`)

### Manual Deployments

```bash
# Get instance IP
INSTANCE_IP=$(./scripts/get-instance-ip.sh staging)

# Deploy backend
./scripts/deploy-backend.sh staging $INSTANCE_IP

# Deploy frontend
./scripts/deploy-frontend.sh staging $INSTANCE_IP

# Health check
./scripts/health-check.sh staging $INSTANCE_IP
```

## Environment Configuration

- **Development**: `config/app-config.yaml`
- **Staging**: `config/staging.yaml`
- **Production**: `config/production.yaml`

## Monitoring

- Backend logs: `/var/log/cvhere-backend.log`
- Frontend logs: `/var/log/cvhere-frontend.log`
- Nginx logs: `/var/log/nginx/`

## Rollback

```bash
# SSH to instance
ssh -i ~/.ssh/cvhere-staging-key.pem ec2-user@$INSTANCE_IP

# Stop services
sudo pkill -f "node.*server.js"
sudo pkill -f "serve"

# Deploy previous version (manual process)
```