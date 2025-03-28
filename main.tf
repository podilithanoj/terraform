terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {
    bucket = "devbackendthanoj"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "ec2_instance" {
  count                         = var.instance_count
  ami                           = var.ami_id
  instance_type                 = element(var.instance_types, count.index % length(var.instance_types))
  subnet_id                     = var.subnet_id
  associate_public_ip_address   = true

  tags = merge(var.common_tags, {
    Name = "app-server-${count.index + 1}"
  })
}