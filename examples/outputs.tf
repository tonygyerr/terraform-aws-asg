output "cloudwatch_log_arn" {
  value = module.asg.cloudwatch_log_arn
}

output "asg_sg_id" {
  value = module.asg.asg_sg_id
}

output "asg_cloudwatch_metric_alarm_memory_high" {
  value = module.asg.asg_cloudwatch_metric_alarm_memory_high
}

output "asg_cloudwatch_metric_alarm_memory_low" {
  value = module.asg.asg_cloudwatch_metric_alarm_memory_low
}

output "asg_cloudwatch_metric_alarm_scale_in" {
  value = module.asg.asg_cloudwatch_metric_alarm_scale_in
}

output "asg_cloudwatch_metric_alarm_scale_out" {
  value = module.asg.asg_cloudwatch_metric_alarm_scale_out
}