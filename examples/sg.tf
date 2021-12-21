resource "aws_security_group_rule" "http"{
  type = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  security_group_id = var.vpc_security_group_ids #application load balancer security group
  source_security_group_id = var.vpc_security_group_ids
}

resource "aws_security_group_rule" "django"{
  type = "ingress"
  from_port   = 8000
  to_port     = 8000
  protocol    = "tcp"
  security_group_id = var.vpc_security_group_ids #application load balancer security group
  source_security_group_id = var.vpc_security_group_ids
}

resource "aws_security_group_rule" "https"{
  type = "ingress"
  from_port   = 443
  to_port     = 443 
  protocol    = "tcp"
  security_group_id = var.vpc_security_group_ids #application load balancer security group
  source_security_group_id = var.vpc_security_group_ids
}