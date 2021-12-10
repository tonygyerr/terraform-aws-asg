#--------------------------------------------------------------
# general
#--------------------------------------------------------------	

app_name                    = "my-asg-application"
aws_key_name                = "my-pem-name"
associate_public_ip_address = "false" # set to true if you want a public ip address associated with your instance.
ami                         = "ami-************"
iam_instance_profile_name   = "SSM-EC2-Instance-Profile"
lb_subnet_ids               = ["subnet-************","subnet-************"]
# subnet_ids               = ["subnet-************","subnet-************"]
lb_prv_subnets              = ["10.0.0.144/28", "10.0.0.160/28", "10.0.0.176/28"]
# private_subnets           = ["10.0.0.48/28", "10.0.0.64/28", "10.0.0.80/28", "10.0.0.96/28", "10.0.0.112/28", "10.0.0.128/28"] #ASG will need access to private application and database subnets

userdata                    = "userdata/userdata.sh"
node_status_check_file      = "userdata/instance_id.sh"
vpc_name                    = "api-vpc"
# vpc_security_group_ids      = ""
name_prefix                 = "ec2-asg"
ecs = {
  instance_type    = "t2.micro"
  min_size         = 3
  max_size         = 3
  desired_capacity = 3
  min_elb_capacity = 3
  health_check_type = "ELB"
  health_check_grace_period = 300
}

vpc_config = {
  region            = "us-east-1a"
  cidr              = "10.0.0.0/16"
  vpc_id            = "vpc-************"
  instance_type     = "t2.small"
  environment       = "dev"
}

tags = {
  Owner   = "my-app"
  env     = "test"
  Region  = "us-east-1"
  project = "my-app"
  Name    = "my-app-asg"
}