output "cloudwatch_log_arn" {
  value = aws_cloudwatch_log_group.flow_log[count.index].arn
}

output "asg_sg_id" {
  value = aws_security_group.asg.id
}

output "asg_cloudwatch_metric_alarm_memory_high" {
  value = "${aws_cloudwatch_metric_alarm.ecs_memory_high.*.arn}"
}

output "asg_cloudwatch_metric_alarm_memory_low" {
  value = "${aws_cloudwatch_metric_alarm.ecs_memory_low.*.arn}"
}

output "asg_cloudwatch_metric_alarm_scale_in" {
  value = "${aws_cloudwatch_metric_alarm.api-ecs-cpu-scale-in.*.arn}"
}

output "asg_cloudwatch_metric_alarm_scale_out" {
  value = "${aws_cloudwatch_metric_alarm.api-ecs-cpu-scaleout.*.arn}"
}