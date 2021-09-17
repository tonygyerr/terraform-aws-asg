variable "aws_key_name" {
  type        = "string"
  description = "aws key name"
  default     = ""
}

variable "lb_name" {
  type        = "string"
  description = "load balancer name"
  default     = "api-pub-alb"
}

variable "lb_prv_subnets" {
  description = "load balancer private subnets for the vpc"
  type        = "list"
  default     = []
}

variable "ami" {
  type = string
  default = ""
}

variable "aws_region" {
  description = "ec2 region for the vpc"
  default     = "us-east-1"
}

variable "tags" {
  type        = "map"
  description = "optional default tags"

  default = {}
}

variable "alb_is_internal" {
  description = "determines if the alb is internal or not"
  default     = "false"
}

variable "ebs_vol_name" {
  description = "name for ebs vol"
  default     = "awse1winprdapi"
}

variable "ebs_vol_az_1a" {
  description = "az for ebs vol"
  default     = "us-east-1a"
}

variable "ebs_vol_az_1b" {
  description = "az for ebs vol"
  default     = "us-east-1b"
}

variable "ebs_vol_az_1d" {
  description = "az for ebs vol"
  default     = "us-east-1d"
}

variable "ebs_vol_size" {
  description = "size for ebs vol"
  default     = "30"
}

variable "ebs_vol_size_db" {
  description = "size for ebs vol"
  default     = "64"
}

variable "ebs_vol_type" {
  description = "volume type for ebs"
  default     = "gp2"
}

variable "ebs_device_name" {
  description = "device name for ebs"
  default     = "/dev/xvdcz"
}

variable "num_pub_subnets" {
  type    = "string"
  default = "3"
}

variable "num_prv_subnets" {
  type    = "string"
  default = "3"
}

variable "num_subnets" {
  type    = "string"
  default = "9"
}

variable "num_route_tables" {
  type    = "string"
  default = "9"
}

variable "ecs" {
  description = "(Required) map of variables for ECS"
  type        = "map"

  default = {
    //instance_type    = "c4.large"
    instance_type    = "t2.micro"
    min_size         = 1
    max_size         = 3
    desired_capacity = 1
    health_check_type = "EC2"
    health_check_grace_period = 300
  }
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  default     = false
}

variable "associate_public_ip_address" {
  description = "Associate the Public IP Address"
  type = bool
  default = false
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  default     = []
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  default     = false
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'"
  default     = 0
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  default     = false
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
  default     = ""
}

variable "monitoring_role_name" {
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled."
  default     = "rds-monitoring-role"
}

variable "create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  default     = false
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  default     = true
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  default     = true
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  default     = false
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
  default     = true
}

variable "reuse_nat_ips" {
  description = "Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable"
  default     = false
}

variable "external_nat_ip_ids" {
  description = "List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips)"
  type        = "list"
  default     = []
}

variable "enable_dynamodb_endpoint" {
  description = "Should be true if you want to provision a DynamoDB endpoint to the VPC"
  default     = false
}

variable "enable_s3_endpoint" {
  description = "Should be true if you want to provision an S3 endpoint to the VPC"
  default     = false
}

variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch"
  default     = true
}

variable "enable_vpn_gateway" {
  description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC"
  default     = false
}

variable "cloud_watch_log_group_name" {
  default = "api-web-cloud-watch-logs"
}

variable "cloud_watch_log_group_retention" {
  default = "30"
}

variable "cloud_watch_mh_comparison_operator" {
  default = "LessThanThreshold"
}

variable "cloud_watch_mh_evaluation_periods" {
  default = "1"
}

variable "cloud_watch_mh_metric_name" {
  default = "MemoryReservation"
}

variable "cloud_watch_mh_namespace" {
  default = "AWS/WEB"
}

variable "cloud_watch_mh_period" {
  default = "300"
}

variable "cloud_watch_mh_statistic" {
  default = "Average"
}

variable "cloud_watch_mh_threshold" {
  default = "30"
}

variable "cloud_watch_mh_description" {
  default = "content delivery memory reservation below 30%"
}

variable "cloud_watch_ml_comparison_operator" {
  default = "GreaterThanThreshold"
}

variable "cloud_watch_ml_evaluation_periods" {
  default = "1"
}

variable "cloud_watch_ml_metric_name" {
  default = "MemoryReservation"
}

variable "cloud_watch_ml_namespace" {
  default = "AWS/WEB"
}

variable "cloud_watch_ml_period" {
  default = "300"
}

variable "cloud_watch_ml_statistic" {
  default = "Average"
}

variable "cloud_watch_ml_threshold" {
  default = "60"
}

variable "cloud_watch_ml_description" {
  default = "content delivery memory reservation above 60%"
}

variable "cloud_watch_so_alarm_name" {
  default = "api-web-cpu-scaleout"
}

variable "cloud_watch_so_comparison_operator" {
  default = "GreaterThanOrEqualToThreshold"
}

variable "cloud_watch_so_evaluation_periods" {
  default = "1"
}

variable "cloud_watch_so_metric_name" {
  default = "CPUUtilization"
}

variable "cloud_watch_so_namespace" {
  default = "AWS/WEB"
}

variable "cloud_watch_so_period" {
  default = "300"
}

variable "cloud_watch_so_statistic" {
  default = "SampleCount"
}

variable "cloud_watch_so_threshold" {
  default = "60.0"
}

variable "cloud_watch_so_description" {
  default = "content delivery memory reservation above 60%"
}

variable "cloud_watch_si_alarm_name" {
  default = "api-web-cpu-scalein"
}

variable "cloud_watch_si_comparison_operator" {
  default = "LessThanOrEqualToThreshold"
}

variable "cloud_watch_si_evaluation_periods" {
  default = "1"
}

variable "cloud_watch_si_metric_name" {
  default = "CPUUtilization"
}

variable "cloud_watch_si_namespace" {
  default = "AWS/WEB"
}

variable "cloud_watch_si_period" {
  default = "300"
}

variable "cloud_watch_si_statistic" {
  default = "SampleCount"
}

variable "cloud_watch_si_threshold" {
  default = "60.0"
}

variable "cloud_watch_si_description" {
  default = "content delivery memory reservation less than 30%"
}

variable "deploy_env_map" {
  type = map
  default = {
    dev = "develop"
    test = "test"
    prod = "prod"
  }
}

variable "lb_subnet_ids" {
  description = "list of load balancer subnet ids"
  type        = list
  default     = []
}

variable "vpc_config" {
  description = "configuration option for vpc"
  type        = map(string)
}

variable "app_name" {
  type        = string
  description = "Application Name"
  default     = ""
}

variable "iam_instance_profile_name" {
  type        = string
  default     = ""
}

variable "vpc_id" {
  type = string
  default = ""
}

variable "instance_type" {
  type = string
  default = ""
}

variable "userdata" {
  type        = string
  default     = ""
}