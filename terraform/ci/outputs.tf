output "project_name" {
  description = "Project name"
  value       = join("", aws_codebuild_project.superb-codebuild-ci.*.name)
}

output "project_id" {
  description = "Project ID"
  value       = join("", aws_codebuild_project.superb-codebuild-ci.*.id)
}

