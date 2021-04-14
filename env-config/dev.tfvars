app_name                  = "thebraghouse"
vpc_name                  = "api-vpc"
aws_key_name              = "bh-mobile-app-server"
ami                       = "ami-0742b4e673072066f"
lb_subnet_ids             = ["subnet-079f4d643fab7611e","subnet-00ccb0bc72db90b8a","subnet-01fcc2f01a879b614"]
lb_prv_subnets            = ["10.0.0.144/28", "10.0.0.160/28", "10.0.0.176/28"]
userdata                  = "userdata/userdata.sh"
iam_instance_profile_name = ""
vpc_config = {
  region            = "us-east-1a"
  cidr              = "10.0.0.0/16"
  vpc_id            = "vpc-050293ce1b9e17213"
  instance_type     = "t2.xlarge"
}