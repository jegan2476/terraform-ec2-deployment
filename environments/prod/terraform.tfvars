aws_region                    = "us-east-1"
environment                   = "prod"
instance_name                 = "prod-web-server"
instance_type                 = "t3.small" # Use "t3.micro" if staying strictly in Free Tier
root_volume_size              = 30
enable_termination_protection = true
allowed_ingress_cidrs         = ["0.0.0.0/0"]
