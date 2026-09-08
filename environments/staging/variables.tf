variable "aws_region" {
  description = "AWS Region to deploy staging resources"
  type        = string
  default     = "us-east-1" # Mumbai (closest region to Chennai)
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "staging"
}

variable "instance_name" {
  description = "Name for the staging EC2 instance"
  type        = string
  default     = "web-server"
}

variable "instance_type" {
  description = "EC2 instance type for staging"
  type        = string
  default     = "t3.micro"
}

variable "root_volume_size" {
  description = "Root disk size in GB"
  type        = number
  default     = 20
}

variable "allowed_ingress_cidrs" {
  description = "CIDRs allowed to access HTTP on port 80"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
