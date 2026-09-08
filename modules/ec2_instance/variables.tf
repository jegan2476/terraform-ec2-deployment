variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

variable "environment" {
  description = "Target deployment environment (e.g., staging, prod)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Custom AMI ID. If left empty, the latest Amazon Linux 2023 AMI is used automatically"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC ID where the security group will reside. If left empty, the Default VPC is used automatically"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "Subnet ID where the instance will launch. If left empty, a Default Subnet is used automatically"
  type        = string
  default     = ""
}

variable "root_volume_size" {
  description = "Size of the root EBS volume in GB"
  type        = number
  default     = 20
}

variable "enable_termination_protection" {
  description = "Enable EC2 API termination protection"
  type        = bool
  default     = false
}

variable "allowed_ingress_cidrs" {
  description = "List of CIDR blocks allowed for inbound HTTP traffic (e.g., [\"0.0.0.0/0\"])"
  type        = list(string)
  default     = []
}
