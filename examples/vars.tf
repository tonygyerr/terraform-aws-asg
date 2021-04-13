variable "aws_key_name" {
  type        = "string"
  description = "aws key name"
  default     = ""
}

variable "lb_subnet_ids" {
  description = "list of subnet load balancer subnet ids"
  type        = list
  default     = []
}

variable "lb_prv_subnets" {
  description = "load balancer private subnets for the vpc"
  type        = "list"
  default     = []
}


variable "tags" {
  type        = "map"
  description = "optional default tags"

  default = {
    Name       = "api"
    Owner      = "cloudops@energy.com"
    CostCenter = "N/A"
    vpc        = "api-vpc"
    env        = "prd"
    project    = "api"
  }
}

variable "aws_region" {
  description = "ec2 region for the vpc"
  default     = "us-east-1"
}

variable "environment_name" {
  description = "enviornment name"
  type        = string
  default     = ""
}

variable "app_name" {
  type        = string
  description = "Application Name"
  default     = ""
}