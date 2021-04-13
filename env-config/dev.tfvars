app_name            = ""
vpc_name            = "api-vpc"
aws_key_name        = ""
ami                 = "ami-0742b4e673072066f"
lb_subnet_ids       = [""]
lb_prv_subnets      = [""]
userdata            = "userdata/userdata.sh"
vpc_config = {
  region            = "us-east-1a"
  cidr              = "10.0.0.0/16"
  vpc_id            = ""
  instance_type     = "t2.xlarge"
}