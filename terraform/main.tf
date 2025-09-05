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
resource "aws_instance" "cvhere" {
  ami           = "ami-0230bd60aa48260c6"  # Amazon Linux 2023 for us-east-1
  instance_type = var.instance_type
  key_name      = data.aws_key_pair.cvhere.key_name
  
  # Allow HTTP traffic
  vpc_security_group_ids = [aws_security_group.cvhere.id]
  
  # Install basic software when server starts
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    
    # Install Docker
    yum install -y docker
    systemctl start docker
    systemctl enable docker
    usermod -a -G docker ec2-user
    
    # Install Docker Compose
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    
    echo "Docker $(docker --version) installed" > /tmp/setup-complete.log
  EOF

  tags = {
    Name        = "cvhere-${var.environment}"
    Environment = var.environment
  }
}

# Use existing SSH Key Pair
data "aws_key_pair" "cvhere" {
  key_name = "cvhere-${var.environment}"
}

# Security group - controls network access
resource "aws_security_group" "cvhere" {
  name        = "cvhere-${var.environment}"
  description = "Security group for CVHere ${var.environment} environment"

  # Allow HTTP (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from anywhere
  }

  # Allow backend API from anywhere (needed for browser access)
  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
    Name = "cvhere-${var.environment}"
  }
}

# Output the server IP so we can connect to it
output "server_ip" {
  description = "Public IP address of the server"
  value       = aws_instance.cvhere.public_ip
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.cvhere.id
}

# Environment-specific outputs for CI/CD compatibility
output "staging_server_ip" {
  description = "Staging server IP (when environment is staging)"
  value       = var.environment == "staging" ? aws_instance.cvhere.public_ip : null
}

output "production_server_ip" {
  description = "Production server IP (when environment is production)"
  value       = var.environment == "production" ? aws_instance.cvhere.public_ip : null
}