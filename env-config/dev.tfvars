#--------------------------------------------------------------
# general
#--------------------------------------------------------------	

app_name                    = "my-asg-application"
aws_key_name                = "my-pem-name"
ami                         = "ami-************"
iam_instance_profile_name   = "SSM-EC2-Instance-Profile"
lb_subnet_ids               = ["subnet-************","subnet-************"]
lb_prv_subnets              = ["10.0.0.144/28", "10.0.0.160/28", "10.0.0.176/28"]
userdata                    = "userdata/userdata.sh"
vpc_name                    = "api-vpc"

vpc_config = {
  region            = "us-east-1a"
  cidr              = "10.0.0.0/16"
  vpc_id            = "vpc-************"
  instance_type     = "t2.small"
  environment       = "dev"
}