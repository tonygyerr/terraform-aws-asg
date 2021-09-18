output "cloudwatch_log_arn" {
  value = module.asg.cloudwatch_log_arn
}

output "alb_sg_id" {
  value = module.asg.alb_sg_id
}