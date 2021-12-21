module "asg" {
  source = "git::https://github.com/tonygyerr/terraform-aws-asg.git"

  app_name                    = "my-app-name"
  ami                         = "ami-0742b4e673072066f"
  associate_public_ip_address = false #set to true of your instance needs a public ip address
  aws_key_name                = "my-app-key-app-server"
  instance_type               = "t2.xlarge"
  subnet_ids                  = ["subnet-***********", "subnet-00cc***********", "subnet-01f************"]
  private_subnets             = ["10.0.0.X/28", "10.0.0.X/28", "10.0.0.X/28", "10.0.0.X/28", "10.0.0.X/28", "10.0.0.X/28"] #ASG will need access to private application and database subnets
  name_prefix                 = "ec2-asg"
  node_status_check_file      = "install/node_status_check.sh"
  userdata                    = "userdata/userdata.sh" #data.template_file.user_data.rendered
  vpc_name                    = "api-vpc"
  vpc_id                      = "vpc-**************"
  vpc_security_group_ids      = [var.vpc_security_group_ids] # use application load balancer security group id
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
    Owner   = "my-app"
    env     = "dev"
    Region  = "us-east-1"
    project = "my-app"
    Name    = "my-app-asg"
  }
}