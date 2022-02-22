#https://github.com/cloudposse/terraform-aws-ecr
provider "aws" {
  region = "us-east-1"
}

locals {
  image_names = var.image_names
}

resource "aws_ecr_repository" "superb-ecr-repo" {
  for_each = toset(local.image_names)
  name                 = each.value
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_images_on_push
  }

}

resource "aws_ecr_repository_policy" "superb-ecr-repo-policy" {
  for_each = toset(local.image_names)
  repository = aws_ecr_repository.superb-ecr-repo[each.value].name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the demo repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}
