variable "instance_types" {
  type = list(string)
  description = "List of allowed EC2 instance types"

  default = ["t4g.micro"]

  validation {
    condition = alltrue([
      for t in var.instance_types : contains(["t4g.micro", "t4g.nano", "t4g.small", "t4g.medium"], t)
    ])
    error_message = "Only the following instance types are allowed: t4g.micro, t4g.nano, t4g.small, t4g.medium"
  }
}

variable "instance_count" {
  type        = number
  default     = 2
  description = "Number of EC2 instances"

  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 5
    error_message = "You must specify between 1 and 5 instances."
  }
}

variable "common_tags" {
  type = map(string)
  description = "Tags to be applied to all resources"

  default = {
    Owner       = "podilithanoj"
    Environment = "dev"
    Project     = "OnwardBills"
  }

  validation {
    condition = (
      contains(keys(var.common_tags), "Owner") &&
      var.common_tags["Owner"] == "podilithanoj" &&
      contains(keys(var.common_tags), "Environment") &&
      contains(["dev", "uat", "prod"], var.common_tags["Environment"]) &&
      contains(keys(var.common_tags), "Project")
    )
    error_message = "Tags must include: Owner=podilithanoj, Environment=[dev|uat|prod], and Project."
  }
}
