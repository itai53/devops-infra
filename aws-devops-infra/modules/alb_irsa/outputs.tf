output "alb_controller_role_arn" {
  description = "IAM Role ARN used by the AWS Load Balancer Controller"
  value       = aws_iam_role.alb_controller.arn
}