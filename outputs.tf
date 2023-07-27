output "alb_dns_name" {
  value       = aws_lb.alb.dns_name
  description = "Use this URL to access your UGF Store API"
}