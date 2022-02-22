output "repository_name" {
  description = "A name of generated ECR repository"
  value       = aws_ecr_repository.superb-ecr-repo[local.image_names[0]].id
}

output "repository_arn" {
  description = "An ARN of generated ECR repository"
  value       = aws_ecr_repository.superb-ecr-repo[local.image_names[0]].arn
}

output "repository_url" {
  description = "A URL of generated ECR repository"
  value       = aws_ecr_repository.superb-ecr-repo[local.image_names[0]].repository_url
}
