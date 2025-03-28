variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID to use for EC2 instances"
  type        = string
  default     = "ami-00101c3551c99b710"  # Make sure this is ARM-compatible for t4g.micro
}

variable "subnet_id" {
  description = "Subnet ID to launch EC2 instances in"
  type        = string
  default     = "subnet-2349730d"
}

variable "instance_types" {
  description = "List of allowed EC2 instance types"
  type        = list(string)
  default     = ["t4g.micro"]
  validation {
    condition     = alltrue([for t in var.instance_types : contains(["t3.micro", "t3.small", "t3.medium", "t4g.micro"], t)])
    error_message = "All instance types must be one of: t3.micro, t3.small, t3.medium, or t4g.micro."
  }
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Owner       = "podilithanoj"
    Environment = "dev"
    Project     = "OnwardBill"
  }
}
