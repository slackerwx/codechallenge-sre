#resource "aws_s3_bucket" "codepipeline_bucket" {
#  bucket = "superb-codepipeline-bucket"
#}
#
#resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
#  bucket = aws_s3_bucket.codepipeline_bucket.id
#  acl    = "private"
#}
#
#resource "aws_iam_role" "codepipeline_role" {
#  name = "superb-codepipeline-role"
#
#  assume_role_policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Effect": "Allow",
#      "Principal": {
#        "Service": "codepipeline.amazonaws.com"
#      },
#      "Action": "sts:AssumeRole"
#    }
#  ]
#}
#EOF
#}
#
#resource "aws_iam_role_policy" "codepipeline_policy" {
#  name = "superb_codepipeline_policy"
#  role = aws_iam_role.codepipeline_role.id
#
#  policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Effect":"Allow",
#      "Action": [
#        "s3:GetObject",
#        "s3:GetObjectVersion",
#        "s3:GetBucketVersioning",
#        "s3:PutObjectAcl",
#        "s3:PutObject"
#      ],
#      "Resource": [
#        "${aws_s3_bucket.codepipeline_bucket.arn}",
#        "${aws_s3_bucket.codepipeline_bucket.arn}/*"
#      ]
#    },
#    {
#      "Effect": "Allow",
#      "Action": [
#        "codestar-connections:UseConnection"
#      ],
#      "Resource": "${aws_codestarconnections_connection.superb_codestarconnection.arn}"
#    },
#    {
#      "Effect": "Allow",
#      "Action": [
#        "codebuild:BatchGetBuilds",
#        "codebuild:StartBuild"
#      ],
#      "Resource": "*"
#    }
#  ]
#}
#EOF
#}
#
#resource "aws_codepipeline" "superb_code_pipeline" {
#  name     = "superb_codepipellline"
#  role_arn = aws_iam_role.codepipeline_role.arn
#  tags     = {
#    Environment = var.environment
#  }
#
#  artifact_store {
#    location = var.codepipeline_bucket_name
#    type     = "S3"
#
#  }
#
#  stage {
#    name = "Source"
#    action {
#      name             = "Source"
#      category         = "Source"
#      owner            = "AWS"
#      provider         = "CodeStarSourceConnection"
#      version          = "1"
#      output_artifacts = ["SourceArtifact"]
#
#      configuration   = {
#        ConnectionArn    = aws_codestarconnections_connection.superb_codestarconnection.arn
#        FullRepositoryId = "slackerwx/codechallenge-sre"
#        BranchName       = "master"
#      }
#    }
#  }
#  stage {
#    name = "Build"
#    action {
#      name            = "Build"
#      category        = "Build"
#      owner           = "AWS"
#      provider        = "CodeBuild"
#      input_artifacts = ["SourceArtifact"]
#      output_artifacts = ["BuildArtifact"]
#      version         = "1"
#
#      configuration = {
#        ProjectName = var.code_build_project
#      }
#    }
#  }
#  stage {
#    name = "Deploy"
#
#    action {
#      name     = "Deploy"
#      category = "Deploy"
#      owner    = "AWS"
#      provider = "CloudFormation"
#      input_artifacts = ["BuildArtifact"]
#      version  = "1"
#
#      configuration = {
#        ActionMode     = "REPLACE_ON_FAILURE"
#        Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
#        OutputFileName = "CreateStackOutput.json"
#        StackName      = "MyStack"
#        TemplatePath   = "build_output::sam-templated.yaml"
#      }
#    }
#  }
#}
#
#resource "aws_codestarconnections_connection" "superb_codestarconnection" {
#  name          = "superb-cs-connection"
#  provider_type = "GitHub"
#}
#
