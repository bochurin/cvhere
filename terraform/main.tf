# Step 1: Basic AWS Infrastructure
# This creates a simple web server on AWS

terraform {
  required_version = ">= 1.0"
  
  # Store state in S3 for persistence across deployments
  backend "s3" {
    bucket = "cvhere-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

# Configure AWS provider
provider "aws" {
  region = "us-east-1"  # Virginia region (cheapest)
}

# Variables - these will be different for staging vs production
variable "environment" {
  description = "Environment name (staging or production)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t2.micro"  # Free tier eligible
}

# Create a simple EC2 instance
resource "aws_instance" "web" {
  ami           = "ami-0230bd60aa48260c6"  # Amazon Linux 2023 for us-east-1
  instance_type = var.instance_type
  key_name      = "cvhere-staging"  # SSH key for access
  
  # Allow HTTP traffic
  vpc_security_group_ids = [aws_security_group.web.id]
  
  # Install basic software when server starts
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y git
    
    # Install Node.js via NVM for ec2-user
    sudo -u ec2-user bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash'
    sudo -u ec2-user bash -c 'source ~/.nvm/nvm.sh && nvm install 18 && nvm use 18 && nvm alias default 18'
    
    echo "Node.js $(sudo -u ec2-user bash -c 'source ~/.nvm/nvm.sh && node --version') installed" > /tmp/setup-complete.log
  EOF

  tags = {
    Name        = "cvhere-${var.environment}"
    Environment = var.environment
  }
}

# Random suffix to avoid naming conflicts
resource "random_id" "suffix" {
  byte_length = 4
}

# Security group - controls network access
resource "aws_security_group" "web" {
  name        = "cvhere-${var.environment}-web-${random_id.suffix.hex}"
  description = "Security group for CVHere ${var.environment} environment"

  # Allow HTTP (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from anywhere
  }

  # Allow backend API only from localhost (frontend can access via localhost)
  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["127.0.0.1/32"]  # Only localhost
  }

  # Allow our frontend (port 3000)
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH for deployment
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cvhere-${var.environment}-security-group"
  }
}

# Output the server IP so we can connect to it
output "server_ip" {
  description = "Public IP address of the web server"
  value       = aws_instance.web.public_ip
}

# Instance ID for status checking
output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web.id
}

# Environment-specific outputs for CI/CD
output "staging_server_ip" {
  description = "Staging server IP (when environment is staging)"
  value       = var.environment == "staging" ? aws_instance.web.public_ip : null
}

output "production_server_ip" {
  description = "Production server IP (when environment is production)"
  value       = var.environment == "production" ? aws_instance.web.public_ip : null
}