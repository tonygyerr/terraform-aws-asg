resource "aws_security_group" "alb" {
  name   = "api-alb-sg"
  vpc_id        = var.vpc_config.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.lb_prv_subnets
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.lb_prv_subnets
  }

  egress {
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = var.lb_prv_subnets
  }

  tags = {
    Name = "${var.app_name}-alb-sg"
  }
}