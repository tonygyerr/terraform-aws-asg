output "cloudwatch_log_arn" {
  value = aws_cloudwatch_log_group.flow_log.arn
}

output "alb_sg_id" {
  value = aws_security_group.alb.id
}