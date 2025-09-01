# Terraform Infrastructure Decision

## 2024-12-19 - Infrastructure as Code Implementation

**Context**: Need to deploy CVHere to AWS for staging and production environments
**Problem**: Manual AWS setup vs Infrastructure as Code approach

**Options Considered**:
1. **Manual AWS Setup** - Quick start, direct console control
2. **Terraform IaC** - Version controlled, reproducible infrastructure
3. **AWS CDK** - TypeScript-based infrastructure

**Decision**: Terraform Infrastructure as Code
**Rationale**: 
- **Reproducible Infrastructure**: Same infrastructure across environments
- **Version Control**: Infrastructure changes tracked in Git
- **Multi-Environment**: Staging and production with same code
- **State Management**: Terraform tracks deployed resources
- **Team Collaboration**: Infrastructure changes via pull requests
- **Change Planning**: Preview changes before applying

**Implementation**:
- **VPC**: Custom VPC with public subnet for web servers
- **EC2**: t2.micro instances (AWS free tier eligible)
- **Security Groups**: HTTP/HTTPS/SSH/API access rules
- **Environment Separation**: staging.tfvars and production.tfvars
- **User Data**: Automated installation of Docker, Node.js, Docker Compose

**Infrastructure Components**:
```
terraform/
├── main.tf              # Main infrastructure configuration
├── staging.tfvars       # Staging environment variables
└── production.tfvars    # Production environment variables
```

**Deployment Commands**:
```bash
# Staging
terraform plan -var-file="staging.tfvars"
terraform apply -var-file="staging.tfvars"

# Production
terraform plan -var-file="production.tfvars"
terraform apply -var-file="production.tfvars"
```

**Benefits**:
- Infrastructure changes reviewed via pull requests
- Consistent environments (staging mirrors production)
- Easy to recreate infrastructure if needed
- Cost tracking via resource tagging
- Automated server setup via user data scripts

**Security Considerations**:
- Security groups restrict access to necessary ports only
- SSH access for server management
- Public subnet for web-facing applications
- Future: Private subnets for database/internal services

**Cost Optimization**:
- t2.micro instances (free tier eligible)
- Single AZ deployment for MVP
- Future: Multi-AZ for production reliability

**Future Enhancements**:
- Application Load Balancer for high availability
- Auto Scaling Groups for traffic handling
- RDS for managed database
- CloudFront for CDN
- Route 53 for DNS management