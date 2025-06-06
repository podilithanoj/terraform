variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID to use for EC2 instances"
  type        = string
  default     = "ami-00101c3551c99b710" # Replace with valid AMI
}

variable "subnet_id" {
  description = "Subnet ID to launch EC2 instances in"
  type        = string
  default     = "subnet-2349730d" # Replace with valid subnet ID
}

variable "instance_types" {
  description = "List of allowed EC2 instance types"
  type        = list(string)
  validation {
    condition = alltrue([
      for t in var.instance_types :
      contains(["t4g.micro", "t4g.nano", "t4g.small", "t4g.medium"], t)
    ])
    error_message = "Instance type must be one of: t4g.micro, t4g.nano, t4g.small, or t4g.medium"
  }
}

variable "instance_count" {
  description = "Number of EC2 instances to launch"
  type        = number
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}
