terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}
provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}
resource "aws_instance" "lalalab" {
  ami                    = "ami-02642c139a9dfb378"
  instance_type          = "t3.medium"
  key_name             = "souleye-key"
  monitoring             = true
  vpc_security_group_ids = [
    "sg-05d1a251614fa89b7",
  ]
  user_data = file("lalalab.sh")
  tags                = {
    Name              = "lalalab"
    environment       = "prod"
    shutdown_nightly  = "false"
    startup_daily     = "true"
  }
   root_block_device {
    delete_on_termination = false
  }
}