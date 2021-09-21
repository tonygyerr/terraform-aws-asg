resource "aws_launch_configuration" "api" {
  count                       = var.vpc_config.environment == var.vpc_config.environment ? 1 : 0
  name                        = "${var.app_name}-aslc"
  image_id                    = var.ami
  instance_type               = var.vpc_config.instance_type
  iam_instance_profile        = var.iam_instance_profile_name
  key_name                    = var.aws_key_name
  security_groups             = ["${aws_security_group.asg.id}"]
  user_data                   = var.userdata
  associate_public_ip_address = var.associate_public_ip_address
  enable_monitoring           = true
  ebs_optimized               = false

  ebs_block_device {
    device_name           = var.ebs_device_name
    volume_size           = var.ebs_vol_size
    volume_type           = var.ebs_vol_type
    delete_on_termination = true
  }

  root_block_device {
    volume_size           = var.ebs_vol_size
    volume_type           = var.ebs_vol_type
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "api" {
  count                     = var.vpc_config.environment == var.vpc_config.environment ? 1 : 0
  name                      = format("%s${var.app_name}-asg", local.name_prefix) #"${var.app_name}-ec2-asg-${count.index}"
  vpc_zone_identifier       = var.lb_subnet_ids
  launch_configuration      = aws_launch_configuration.api.*.name[count.index]
  desired_capacity          = var.ecs["desired_capacity"]
  health_check_grace_period = var.ecs["health_check_grace_period"]
  health_check_type         = var.ecs["health_check_type"]
  min_size                  = var.ecs["min_size"]
  max_size                  = var.ecs["max_size"]
  # depends_on                = ["aws_launch_configuration.api"]

  tag {
    key                 = "Name"
    value               = format("%s${var.app_name}-asg", local.name_prefix) #"${var.app_name}-ec2-asg-${count.index}"
    propagate_at_launch = true
  }
  tag {
    key                 = "Owner"
    value               = var.tags.Owner
    propagate_at_launch = true
  }
  tag {
    key                 = "Env"
    value               = var.tags.env
    propagate_at_launch = true
  }
  tag {
    key                 = "Region"
    value               = var.tags.Region
    propagate_at_launch = true
  }
  tag {
    key                 = "project"
    value               = var.tags.project
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "scale_out" {
  count                  = var.vpc_config.environment == var.vpc_config.environment ? 1 : 0
  name                   = "${replace(var.tags["Name"], "/", "-")}-scale-out"
  scaling_adjustment     = "1"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "300"
  autoscaling_group_name = aws_autoscaling_group.api[count.index].name
}

resource "aws_autoscaling_policy" "scale_in" {
  count                  = var.vpc_config.environment == var.vpc_config.environment ? 1 : 0
  name                   = "${replace(var.tags["Name"], "/", "-")}-scale-in"
  scaling_adjustment     = "-1"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "300"
  autoscaling_group_name = aws_autoscaling_group.api[count.index].name
}

resource "aws_autoscaling_policy" "ec2_ecs_asg_scale_out" {
  count                  = var.vpc_config.environment == var.vpc_config.environment ? 1 : 0
  name                   = "${replace(var.tags["project"], "/", "-")}-scale-out"
  scaling_adjustment     = "1"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "300"
  autoscaling_group_name = aws_autoscaling_group.api[count.index].name
}

resource "aws_autoscaling_policy" "ec2_ecs_asg_scale_in" {
  count                  = var.vpc_config.environment == var.vpc_config.environment ? 1 : 0
  name                   = "${replace(var.tags["project"], "/", "-")}-scale-in"
  scaling_adjustment     = "-1"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "300"
  autoscaling_group_name = aws_autoscaling_group.api[count.index].name
}

# data "aws_vpc" "this" {
#   filter {
#     name   = "tag:Name"
#     values = [var.vpc_name]
#   }
# }

# data "aws_instance" "server" {
#   instance_id = var.instance_id_1

#   filter {
#     name   = "tag:aws:autoscaling:groupName"
#     values = [var.asg_name]
#   }
#   filter {
#     name   = "tag:Name"
#     values = [var.asg_name]
#   }
# }

# resource "aws_alb_target_group_attachment" "http" {
#   target_group_arn       = aws_lb_target_group.http.arn
#   target_id              = data.aws_instance.server.id #var.vpc_config.instance_id
#   port                   = 80
# }

# resource "aws_alb_target_group_attachment" "https" {
#   target_group_arn       = aws_lb_target_group.https.arn
#   target_id              = data.aws_instance.server.id #var.vpc_config.instance_id
#   port                   = 443
# }