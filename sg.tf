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
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.private_subnets #application and database subnets
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.vpc_config.cidr #application and database subnets
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.open_cidr]
  }
}

# resource "aws_security_group_rule" "http"{
#   type = "ingress"
#   from_port   = 80
#   to_port     = 80
#   protocol    = "tcp"
#   security_group_id = aws_security_group.asg.id
#   source_security_group_id = aws_security_group.asg.id
# }

# resource "aws_security_group_rule" "django"{
#   type = "ingress"
#   from_port   = 8000
#   to_port     = 8000
#   protocol    = "tcp"
#   security_group_id = aws_security_group.asg.id
#   source_security_group_id = aws_security_group.asg.id
# }

# resource "aws_security_group_rule" "sqs"{
#   type = "ingress"
#   from_port   = 9324
#   to_port     = 9324
#   protocol    = "tcp"
#   security_group_id = aws_security_group.asg.id
#   source_security_group_id = aws_security_group.asg.id
# }

# resource "aws_security_group_rule" "https"{
#   type = "ingress"
#   from_port   = 443
#   to_port     = 443 
#   protocol    = "tcp"
#   security_group_id = aws_security_group.asg.id
#   source_security_group_id = aws_security_group.asg.id
# }

# resource "aws_security_group_rule" "vpc"{
#   type = "ingress"
#   from_port   = 0
#   to_port     = 65535
#   protocol    = "tcp"
#   security_group_id = aws_security_group.asg.id
#   source_security_group_id = aws_security_group.asg.id
# }