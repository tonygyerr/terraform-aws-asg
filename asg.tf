resource "aws_autoscaling_group" "api" {
  count                     = var.vpc_config.environment == var.vpc_config.environment ? 1 : 0
  name                      = format("%s${var.app_name}-asg", local.name_prefix) #"${var.app_name}-ec2-asg-${count.index}"
  vpc_zone_identifier       = var.subnet_ids
  launch_configuration      = aws_launch_configuration.api.*.name[count.index]
  desired_capacity          = var.ecs["desired_capacity"]
  health_check_grace_period = var.ecs["health_check_grace_period"]
  health_check_type         = var.ecs["health_check_type"]
  min_size                  = var.ecs["min_size"]
  max_size                  = var.ecs["max_size"]
  # depends_on                = ["aws_launch_configuration.api"]

  tag {
    key                 = "Name"
    value               = format("%s${var.app_name}-asg-${count.index}", local.name_prefix) #"${var.app_name}-ec2-asg-${count.index}"
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
  name                   = "${replace(var.app_name, "/", "-")}-scale-out"
  scaling_adjustment     = "1"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "300"
  autoscaling_group_name = aws_autoscaling_group.api[count.index].name
}

resource "aws_autoscaling_policy" "scale_in" {
  count                  = var.vpc_config.environment == var.vpc_config.environment ? 1 : 0
  name                   = "${replace(var.app_name, "/", "-")}-scale-in"
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