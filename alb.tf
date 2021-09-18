resource "aws_alb" "public" {
  name                       = var.lb_name
  internal                   = false
  security_groups            = ["${aws_security_group.alb.id}"]
  subnets                    = var.lb_subnet_ids
  idle_timeout               = 400
  ip_address_type            = "ipv4"
  enable_deletion_protection = false

  tags = merge(map("Name", local.environment_name != local.tf_workspace ? "${local.tf_workspace}-${var.app_name}-pub-alb" : "${var.app_name}-pub-alb"), merge(var.tags))
}

resource "aws_alb_target_group" "api-alb-tg" {
  name = "${var.app_name}-api-alb-tg"

  # Switch to 443 eventually
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_config.vpc_id

  stickiness {
    type = "lb_cookie"
  }

  health_check {
    path = "/"
  }

  tags = merge(map("Name", local.environment_name != local.tf_workspace ? "${local.tf_workspace}-${var.app_name}-api-alb-tg" : "${var.app_name}--api-alb-tg"), merge(var.tags))
}


resource "aws_alb_listener" "api-alb-listener" {
  load_balancer_arn = aws_alb.public.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.api-alb-tg.id
    type             = "forward"
  }
}
