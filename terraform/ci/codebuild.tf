
resource "aws_s3_bucket" "superb-s3-ci" {
  bucket = var.codebuild_bucket_name
}

resource "aws_s3_bucket_acl" "superb-s3-ci-acl" {
  bucket = aws_s3_bucket.superb-s3-ci.id
  acl    = "private"
}

resource "aws_iam_role" "superb-iam-ci" {
  name = "superb-iam-codebuild-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "superb-iam-rp" {
  name = "superb_codebuild_policy"
  role = aws_iam_role.superb-iam-ci.name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload  ",
          "ecr:GetAuthorizationToken",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeDhcpOptions",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterfacePermission"
      ],
      "Resource": [
        "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:network-interface/*"
      ],
      "Condition": {
        "StringEquals": {
          "ec2:Subnet": [
            "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:subnet/${var.subnet_public}",
            "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:subnet/${var.subnet_private}"
          ],
          "ec2:AuthorizedService": "codebuild.amazonaws.com"
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${aws_s3_bucket.superb-s3-ci.arn}",
        "${aws_s3_bucket.superb-s3-ci.arn}/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_security_group" "build" {
  name   = "build"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "build_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.build.id
}


resource "aws_codebuild_project" "superb-codebuild-ci" {
  name          = var.code_build_project
  description   = "superb-sre-challenge"
  build_timeout = var.build_timeout
  service_role  = aws_iam_role.superb-iam-ci.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.superb-s3-ci.bucket
  }

  environment {
    compute_type                = var.build_compute_type
    image                       = var.build_image
    type                        = var.build_type
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = var.privileged_mode

    dynamic "environment_variable" {
      for_each = var.environment_variables
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
        type  = environment_variable.value.type
      }
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.superb-s3-ci.id}/build-log"
    }
  }


  source {
    type            = "GITHUB"
    location        = var.repository_name
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }

  tags = {
    Environment = var.environment
  }

}
