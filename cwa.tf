resource "aws_cloudwatch_log_group" "api_flow_log" {
  name              = "${var.cloud_watch_log_group_name}"
  retention_in_days = "${var.cloud_watch_log_group_retention}"
}

resource "aws_cloudwatch_metric_alarm" "ecs_memory_high" {
  alarm_name          = "${aws_autoscaling_group.api.name}-memory-reservation-high"
  comparison_operator = "${var.cloud_watch_mh_comparison_operator}"
  evaluation_periods  = "${var.cloud_watch_mh_evaluation_periods}"
  metric_name         = "${var.cloud_watch_mh_metric_name}"
  namespace           = "${var.cloud_watch_mh_namespace}"
  period              = "${var.cloud_watch_mh_period}"
  statistic           = "${var.cloud_watch_mh_statistic}"
  threshold           = "${var.cloud_watch_mh_threshold}"

  alarm_description = "${var.cloud_watch_mh_description}"
  alarm_actions     = ["${aws_autoscaling_policy.api_ec2_ecs_asg_scale_in.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "ecs_memory_low" {
  alarm_name          = "${aws_autoscaling_group.api.name}-memory-reservation-low"
  comparison_operator = "${var.cloud_watch_ml_comparison_operator}"
  evaluation_periods  = "${var.cloud_watch_ml_evaluation_periods}"
  metric_name         = "${var.cloud_watch_ml_metric_name}"
  namespace           = "${var.cloud_watch_ml_namespace}"
  period              = "${var.cloud_watch_ml_period}"
  statistic           = "${var.cloud_watch_ml_statistic}"
  threshold           = "${var.cloud_watch_ml_threshold}"

  alarm_description = "${var.cloud_watch_ml_description}"
  alarm_actions     = ["${aws_autoscaling_policy.api_ec2_ecs_asg_scale_out.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "api-ecs-cpu-scale-in" {
  alarm_name          = "${var.cloud_watch_si_alarm_name}"
  comparison_operator = "${var.cloud_watch_si_comparison_operator}"
  evaluation_periods  = "${var.cloud_watch_si_evaluation_periods}"
  metric_name         = "${var.cloud_watch_si_metric_name}"
  namespace           = "${var.cloud_watch_si_namespace}"
  period              = "${var.cloud_watch_si_period}"
  statistic           = "${var.cloud_watch_si_statistic}"
  threshold           = "${var.cloud_watch_si_threshold}"

  alarm_description   = "${var.cloud_watch_si_description}"
  alarm_actions       = ["${aws_autoscaling_policy.api_ec2_ecs_asg_scale_in.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "api-ecs-cpu-scaleout" {
  alarm_name          = "${var.cloud_watch_so_alarm_name}"
  comparison_operator = "${var.cloud_watch_so_comparison_operator}"
  evaluation_periods  = "${var.cloud_watch_so_evaluation_periods}"
  metric_name         = "${var.cloud_watch_so_metric_name}"
  namespace           = "${var.cloud_watch_so_namespace}"
  period              = "${var.cloud_watch_so_period}"
  statistic           = "${var.cloud_watch_so_statistic}"
  threshold           = "${var.cloud_watch_so_threshold}"

  alarm_description   = "${var.cloud_watch_so_description}"
  alarm_actions       = ["${aws_autoscaling_policy.api_ec2_ecs_asg_scale_out.arn}"]
}