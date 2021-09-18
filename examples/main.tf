module "asg" {
  source = "git::https://github.com/tonygyerr/terraform-aws-asg.git"

  app_name                    = "my-app-name"
  ami                         = "ami-0742b4e673072066f"
  associate_public_ip_address = true
  aws_key_name                = "my-app-key-app-server"
  instance_type               = "t2.xlarge"
  lb_prv_subnets              = ["10.0.0.144/28", "10.0.0.160/28", "10.0.0.176/28"]
  lb_subnet_ids               = ["subnet-***********", "subnet-00cc***********", "subnet-01f************"]
  name_prefix                 = "ec2-asg"
  userdata                    = "userdata/userdata.sh" #data.template_file.user_data.rendered
  vpc_name                    = "api-vpc"
  vpc_id                      = "vpc-**************"
  vpc_security_group_ids      = [module.api.alb_sg_id] #var.vpc_security_group_ids
  ecs = {
    instance_type             = "t2.micro"
    min_size                  = 3
    max_size                  = 3
    desired_capacity          = 3
    min_elb_capacity          = 3
    health_check_type         = "ELB"
    health_check_grace_period = 300
  }
  vpc_config = {
    region        = "us-east-1a"
    cidr          = "10.0.0.0/16"
    vpc_id        = "vpc-************"
    instance_type = "t2.small"
    environment   = "dev"
  }
  tags = {
    Owner   = "braghouse"
    env     = "test"
    Region  = "us-east-1"
    project = "brag"
    Name    = "braghouse-asg"
  }
}