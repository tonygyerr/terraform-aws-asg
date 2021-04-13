resource "aws_launch_configuration" "api" {
  name                        = "${var.app_name}-aslc-20200411a"
  image_id                    = var.ami
  instance_type               = var.vpc_config.instance_type
  //iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"
  key_name                    = var.aws_key_name 
  security_groups             = ["${aws_security_group.alb.id}"]
  user_data                   = "value"
  associate_public_ip_address = false
  enable_monitoring           = true
  ebs_optimized               = false
  
  ebs_block_device {
    device_name           = "${var.ebs_device_name}"
    volume_size           = "${var.ebs_vol_size}"
    volume_type           = "${var.ebs_vol_type}"
    delete_on_termination = true
  }

  root_block_device {
    volume_size           = "${var.ebs_vol_size}"
    volume_type           = "${var.ebs_vol_type}"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "api" {
  name                      = "${var.app_name}-ec2-ecs-asg"
  vpc_zone_identifier       = var.lb_subnet_ids
  launch_configuration      = "${aws_launch_configuration.api.name}"
  desired_capacity          = "${var.ecs["desired_capacity"]}"
  health_check_grace_period = "${var.ecs["health_check_grace_period"]}"
  health_check_type         = "${var.ecs["health_check_type"]}"
  min_size                  = "${var.ecs["min_size"]}"
  max_size                  = "${var.ecs["max_size"]}"
  depends_on                = ["aws_launch_configuration.api"]

  tag {
    key                 = "Name"
    value               = "${var.app_name}-ec2-ecs-asg"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "api_scale_out" {
  name                   = "${replace(var.tags["Name"], "/", "-")}-scale-out"
  scaling_adjustment     = "1"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "300"
  autoscaling_group_name = "${aws_autoscaling_group.api.name}"
}

resource "aws_autoscaling_policy" "api_scale_in" {
  name                   = "${replace(var.tags["Name"], "/", "-")}-scale-in"
  scaling_adjustment     = "-1"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "300"
  autoscaling_group_name = "${aws_autoscaling_group.api.name}"
}

resource "aws_autoscaling_policy" "api_ec2_ecs_asg_scale_out" {
  name                   = "${replace(var.tags["project"], "/", "-")}-scale-out"
  scaling_adjustment     = "1"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "300"
  autoscaling_group_name = "${aws_autoscaling_group.api.name}"
}

resource "aws_autoscaling_policy" "api_ec2_ecs_asg_scale_in" {
  name                   = "${replace(var.tags["project"], "/", "-")}-scale-in"
  scaling_adjustment     = "-1"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "300"
  autoscaling_group_name = "${aws_autoscaling_group.api.name}"
}