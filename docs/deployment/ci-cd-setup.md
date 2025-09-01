# CI/CD Pipeline Setup

## Overview

The CVHere project uses GitHub Actions for CI/CD with the following workflows:

- **Backend CI/CD** (`.github/workflows/backend.yml`)
- **Frontend CI/CD** (`.github/workflows/frontend.yml`)
- **Terraform Infrastructure** (`.github/workflows/terraform.yml`)

## Workflow Triggers

### Backend & Frontend
- **CI**: Push/PR to `develop` or `main` branches
- **Staging Deploy**: Push to `develop` branch
- **Production Deploy**: Git tags starting with `v` (e.g., `v1.0.0`)

### Terraform
- **Plan**: Push/PR to `main` branch
- **Apply Staging**: Push to `main` branch
- **Apply Production**: Git tags starting with `v`

## Required GitHub Secrets

```
AWS_ACCESS_KEY_ID=your_aws_access_key
AWS_SECRET_ACCESS_KEY=your_aws_secret_key
```

## Deployment Process

1. **Infrastructure First**: Terraform creates AWS resources
2. **Backend Deploy**: Node.js API deployment to EC2
3. **Frontend Deploy**: React app deployment to EC2
4. **Health Checks**: Automated verification

## Environment Configuration

### Staging
- Branch: `develop`
- Domain: `staging.cvhere.net` (configure DNS)
- Instance: `t2.micro`

### Production
- Trigger: Git tags (`v*`)
- Domain: `cvhere.net` (configure DNS)
- Instance: `t2.small`

## Manual Operations

```bash
# Create a production release
git tag v1.0.0
git push origin v1.0.0

# Emergency rollback
ssh ec2-user@instance-ip
sudo systemctl restart cvhere-backend
sudo systemctl restart cvhere-frontend
```

## Monitoring

- GitHub Actions logs
- AWS CloudWatch (if configured)
- Application logs on EC2 instances