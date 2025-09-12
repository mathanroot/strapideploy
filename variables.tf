# AWS region
variable "aws_region" {
  default = "us-east-1"
}

# VPC CIDR
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Public subnets (can have multiple)
variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.4.0/24"]  # At least 2 if you want high availability
}

# Private subnets (for RDS and private resources)
variable "private_subnet_cidrs" {
  default = ["10.0.2.0/24", "10.0.3.0/24"]  # Must have 2 for RDS AZ coverage
}

# EC2 instance type
variable "ec2_instance_type" {
  default = "t3.medium"
}

# SSH Key Pair Name
variable "key_pair_name" {
  description = "Existing key pair name for SSH access"
}

# RDS database credentials
variable "db_username" {
  default = "strapiuser"
}

variable "db_password" {
  default = "StrapiPass123!"
  sensitive = true
}

# Domain name for Route53
variable "domain_name" {
  default = "strapi.com"  # Replace with your real domain
}

