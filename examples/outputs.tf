output "asg_id" {
  value = module.asg.asg_id
}

output "asg_launch_configuration_id" {
  value  = module.asg.asg_launch_configuration_id
}

output "asg_name" {
  value  = module.asg[count.index].asg_name
}

output "cloudwatch_log_arn" {
  value = module.asg.cloudwatch_log_arn
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