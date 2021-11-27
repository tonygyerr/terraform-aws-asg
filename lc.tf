resource "random_id" "asg" {
  byte_length = 20 * 3 / 4
}

resource "aws_launch_configuration" "api" {
  count                       = var.vpc_config.environment == var.vpc_config.environment ? 1 : 0
  name                        = "${var.app_name}-aslc-${random_id.asg.id}"
  image_id                    = var.ami
  instance_type               = var.vpc_config.instance_type
  iam_instance_profile        = var.iam_instance_profile_name
  key_name                    = var.aws_key_name
  security_groups             = var.vpc_security_group_ids
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
