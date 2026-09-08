terraform {
  backend "s3" {
    bucket         = "my-tf-state-ec2-learning-12345" # Your S3 bucket name
    key            = "prod/ec2/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
