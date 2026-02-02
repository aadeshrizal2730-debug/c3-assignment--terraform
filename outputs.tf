output "alb_dns_name" {
  description = "Public URL of the Application Load Balancer"
  value       = aws_lb.app.dns_name
}
output "target_group_arn" {
   value = aws_lb_target_group.app.arn
}

