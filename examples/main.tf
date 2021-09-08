module "asg" {
  source = "git::https://github.com/tonygyerr/terraform-aws-asg.git"

  app_name                = "my-app-name"
  ami                     = "ami-0742b4e673072066f"
  aws_key_name            = "my-app-key-app-server"
  instance_type           = var.vpc_config.instance_type
  lb_prv_subnets          = ["10.0.0.144/28", "10.0.0.160/28", "10.0.0.176/28"]
  lb_subnet_ids           = ["subnet-***********","subnet-00cc***********","subnet-01f************"]
  userdata                = "userdata/userdata.sh" #data.template_file.user_data.rendered
  vpc_name                = "api-vpc"
  vpc_id                  = var.vpc_config.vpc_id
  vpc_security_group_ids  = [module.api.alb_sg_id]
}