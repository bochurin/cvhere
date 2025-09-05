# Resource Naming Decision

## 2025-09-04 - Consistent Resource Naming Strategy

**Context**: Need consistent naming for AWS resources, Docker containers, and services
**Problem**: Default naming often includes AWS prefixes/postfixes or resource type prefixes that create confusion

**Requirements**:
- Project name must be included in all resources
- No AWS prefixes/postfixes (no "aws-", "-sg", "-vpc", etc.)
- No resource type prefixes/postfixes (no "ec2-", "-instance", "-container", etc.)
- Environment separation (staging/production)
- Clear, readable names

**Decision**: Use `cvhere-{environment}` pattern for all resources

**Implementation**:

### AWS Resources
```hcl
# EC2 Instance
resource "aws_instance" "cvhere" {
  tags = {
    Name = "cvhere-${var.environment}"
  }
}

# Security Group
resource "aws_security_group" "cvhere" {
  name = "cvhere-${var.environment}"
}

# Key Pair
resource "aws_key_pair" "cvhere" {
  key_name = "cvhere-${var.environment}"
}
```

### Docker Resources
```yaml
services:
  cvhere-backend:
    container_name: cvhere-backend
  cvhere-frontend:
    container_name: cvhere-frontend
networks:
  cvhere-network:
    name: cvhere-network
```

### S3 Buckets
```
cvhere-terraform-state
cvhere-assets-staging
cvhere-assets-production
```

**Benefits**:
- **Consistent naming** across all resources
- **Easy identification** - all resources clearly belong to cvhere project
- **Environment separation** - staging vs production clear
- **No confusion** - no AWS or resource type noise in names
- **Readable** - names describe purpose, not implementation

**Examples**:
- ✅ `cvhere-staging` (EC2 instance)
- ✅ `cvhere-backend` (Docker container)
- ✅ `cvhere-network` (Docker network)
- ❌ `aws-cvhere-ec2-instance-staging`
- ❌ `cvhere-staging-sg`
- ❌ `ec2-cvhere-backend-container`