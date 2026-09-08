output "prod_instance_id" {
  description = "EC2 Instance ID in Production"
  value       = module.ec2_prod.instance_id
}

output "prod_public_ip" {
  description = "Public IP of Production EC2 Instance"
  value       = module.ec2_prod.public_ip
}

output "prod_security_group_id" {
  description = "Security Group ID in Production"
  value       = module.ec2_prod.security_group_id
}
