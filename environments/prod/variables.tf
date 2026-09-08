variable "aws_region" {
  description = "AWS Region for production resources"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "prod"
}

variable "instance_name" {
  description = "Name for the production EC2 instance"
  type        = string
  default     = "prod-web-server"
}

variable "instance_type" {
  description = "EC2 instance type for production"
  type        = string
  default     = "t3.small" # Can also use t3.micro for free tier learning
}

variable "root_volume_size" {
  description = "Root disk size in GB"
  type        = number
  default     = 30
}

variable "enable_termination_protection" {
  description = "Prevent accidental termination of production instance"
  type        = bool
  default     = true
}

variable "allowed_ingress_cidrs" {
  description = "CIDRs allowed to access HTTP on port 80"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
