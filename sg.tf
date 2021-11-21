resource "aws_security_group" "asg" {
  name   = "${var.app_name}-asg-sg"
  vpc_id = var.vpc_config.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.private_subnets #application and database subnets
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.private_subnets #application and database subnets
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = var.private_subnets #application and database subnets
  }

  ingress {
    from_port   = 9324 #sqs
    to_port     = 9324
    protocol    = "tcp"
    cidr_blocks = var.private_subnets #application and database subnets
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.private_subnets #application and database subnets
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.open_cidr]
  }
}