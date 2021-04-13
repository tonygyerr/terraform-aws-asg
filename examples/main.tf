module "asg" {
  source = "git::https://github.com/tonygyerr/terraform-aws-asg.git"

  app_name                = var.app_name
  ami                     = var.ami
  aws_key_name            = var.aws_key_name
  instance_type           = var.vpc_config.instance_type
  lb_prv_subnets          = var.lb_prv_subnets
  lb_subnet_ids           = var.lb_subnet_ids
  userdata                = data.template_file.user_data.rendered
  vpc_name                = var.vpc_name
  vpc_id                  = var.vpc_config.vpc_id
  vpc_security_group_ids  = [module.api.alb_sg_id]
}