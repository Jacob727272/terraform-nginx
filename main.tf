terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# ----------------------------
# Random suffix for uniqueness
# ----------------------------
resource "random_id" "suffix" {
  byte_length = 3
}

# ----------------------------
# Get default VPC
# ----------------------------
data "aws_vpc" "default" {
  default = true
}

# ----------------------------
# Security Group
# ----------------------------
resource "aws_security_group" "nginx_sg" {

  name        = "nginx-sg-jenkins-${var.server_name}-${random_id.suffix.hex}"
  description = "Managed by Terraform"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-sg-${var.server_name}"
  }
}

# ----------------------------
# EC2 Instance
# ----------------------------
resource "aws_instance" "nginx_server" {

  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id = "subnet-0c373b0b7d59638de"

  key_name = var.key_name

  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.nginx_sg.id
  ]

  user_data = file("userdata.sh")

  tags = {
    Name = var.server_name
  }
}
