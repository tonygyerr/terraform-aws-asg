variable "aws_key_name" {
  type        = string
  description = "aws key name"
  default     = ""
}

variable "subnet_ids" {
  description = "list of subnet load balancer subnet ids"
  type        = list(any)
  default     = []
}

variable "private_subnets" {
  description = "list of private subnets for application and database layer"
  type        = list(string)
  default     = []
}

variable "vpc_security_group_ids" {
  description = "list of security group ids"
  type        = list(any)
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "optional default tags"

  default = {}
}

variable "name_prefix" {
  type    = string
  default = ""
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

variable "iam_instance_profile_name" {
  type    = string
  default = ""
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "instance_type" {
  type    = string
  default = ""
}

variable "userdata" {
  type    = string
  default = ""
}

variable "associate_public_ip_address" {
  description = "Associate the Public IP Address"
  type        = bool
  default     = false
}

variable "ecs" {
  description = "(Required) map of variables for ECS"
  type        = map(string)

  default = {}
}

variable "node_status_check_file" {
  type = string
  default = ""
}

variable "node_cron_primary_file" {
  type = string
  default = ""
}

variable "node_cron_secondary_file" {
  type = string
  default = ""
}

variable "node_celery_primary_file" {
  type = string
  default = ""
}

variable "node_celery_secondary_file" {
  type = string
  default = ""
}