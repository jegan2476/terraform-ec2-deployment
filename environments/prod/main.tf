terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "Learning-CI-CD"
      ManagedBy   = "Terraform"
      Criticality = "High"
    }
  }
}

# Call the reusable EC2 module for Production
module "ec2_prod" {
  source = "../../modules/ec2_instance"

  instance_name                 = var.instance_name
  environment                   = var.environment
  instance_type                 = var.instance_type
  root_volume_size              = var.root_volume_size
  enable_termination_protection = var.enable_termination_protection
  allowed_ingress_cidrs         = var.allowed_ingress_cidrs
}
