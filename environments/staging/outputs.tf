output "staging_instance_id" {
  description = "EC2 Instance ID in Staging"
  value       = module.ec2_staging.instance_id
}

output "staging_public_ip" {
  description = "Public IP of Staging EC2 Instance"
  value       = module.ec2_staging.public_ip
}

output "staging_security_group_id" {
  description = "Security Group ID in Staging"
  value       = module.ec2_staging.security_group_id
}
