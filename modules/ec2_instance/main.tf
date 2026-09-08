# 1. Automatic AMI discovery (Amazon Linux 2023) if ami_id is not provided
data "aws_ami" "amazon_linux_2023" {
  count       = var.ami_id == "" ? 1 : 0
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 2. Automatic VPC discovery if vpc_id is not provided
data "aws_vpc" "default" {
  count   = var.vpc_id == "" ? 1 : 0
  default = true
}

locals {
  ami    = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux_2023[0].id
  vpc_id = var.vpc_id != "" ? var.vpc_id : data.aws_vpc.default[0].id
}

# 3. Automatic Subnet discovery if subnet_id is not provided
data "aws_subnets" "default" {
  count = var.subnet_id == "" ? 1 : 0
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
}

locals {
  subnet_id = var.subnet_id != "" ? var.subnet_id : data.aws_subnets.default[0].ids[0]
}

# 4. Security Group
resource "aws_security_group" "instance_sg" {
  name_prefix = "${var.environment}-${var.instance_name}-sg-"
  description = "Security group for ${var.instance_name} in ${var.environment}"
  vpc_id      = local.vpc_id

  dynamic "ingress" {
    for_each = length(var.allowed_ingress_cidrs) > 0 ? [1] : []
    content {
      description = "HTTP Inbound"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = var.allowed_ingress_cidrs
    }
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-${var.instance_name}-sg"
    Environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}

# 5. EC2 Instance
resource "aws_instance" "this" {
  ami                     = local.ami
  instance_type           = var.instance_type
  subnet_id               = local.subnet_id
  vpc_security_group_ids  = [aws_security_group.instance_sg.id]
  disable_api_termination = var.enable_termination_protection

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    encrypted             = true
    delete_on_termination = true

    tags = {
      Name        = "${var.environment}-${var.instance_name}-root-vol"
      Environment = var.environment
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tags = {
    Name        = "${var.environment}-${var.instance_name}"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
