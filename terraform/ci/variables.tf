variable "environment_variables" {
  type = list(object(
    {
      name  = string
      value = string
      type  = string
    }))

  default = [
    {
      name  = "AUTH_REPOSITORY_URI"
      value = "984392288310.dkr.ecr.us-east-1.amazonaws.com/auth"
      type  = "PLAINTEXT"
    },
    {
      name  = "BOOKING_REPOSITORY_URI"
      value = "984392288310.dkr.ecr.us-east-1.amazonaws.com/booking"
      type  = "PLAINTEXT"
    },
    {
      name  = "CLIENT_REPOSITORY_URI"
      value = "984392288310.dkr.ecr.us-east-1.amazonaws.com/client"
      type  = "PLAINTEXT"
    },
    {
      name  = "GRAPHQL_REPOSITORY_URI"
      value = "984392288310.dkr.ecr.us-east-1.amazonaws.com/graphql"
      type  = "PLAINTEXT"
    },
    {
      name  = "EKS_NAME"
      value = "984392288310.dkr.ecr.us-east-1.amazonaws.com/graphql"
      type  = "PLAINTEXT"
    },
    {
      name  = "AWS_ACCOUNTID"
      value = "984392288310"
      type  = "PLAINTEXT"
    },
    {
      name  = "REGION"
      value = "us-east-1"
      type  = "PLAINTEXT"
    }
  ]

  description = "A list of maps, that contain the keys 'name', 'value', and 'type' to be used as additional environment variables for the build. Valid types are 'PLAINTEXT', 'PARAMETER_STORE', or 'SECRETS_MANAGER'"
}

variable "build_image" {
  type        = string
  default     = "aws/codebuild/standard:5.0"
  description = "Docker image for build environment, e.g. 'aws/codebuild/standard:2.0' or 'aws/codebuild/eb-nodejs-6.10.0-amazonlinux-64:4.0.0'. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref.html"
}

variable "build_compute_type" {
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
  description = "Instance type of the build instance"
}

variable "build_timeout" {
  default     = 60
  description = "How long in minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed"
}

variable "build_type" {
  type        = string
  default     = "LINUX_CONTAINER"
  description = "The type of build environment, e.g. 'LINUX_CONTAINER' or 'WINDOWS_CONTAINER'"
}

variable "privileged_mode" {
  type        = bool
  default     = true
  description = "(Optional) If set to true, enables running the Docker daemon inside a Docker container on the CodeBuild instance. Used when building Docker images"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "(Optional) AWS Region, e.g. us-east-1. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}

variable "aws_account_id" {
  type        = string
  default     = "984392288310"
  description = "(Optional) AWS Account ID. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}

#FIXME: hard-coded
variable "vpc_id" {
  type = string
  default = "vpc-0f84941e7ad9e36b3"
}

#FIXME: hard-coded
variable "subnet_public" {
  type = string
  default = "subnet-08fcfdd3b1a98301e"
}

#FIXME: hard-coded
variable "subnet_private" {
  type = string
  default = "subnet-079479d6d6410aeab"
}

variable "repository_name" {
  type = string
  default = "https://github.com/slackerwx/codechallenge-sre.git"
}

variable "repository_branch" {
  default = "master"
  type = string
}

variable "repository_owner" {
  default = "slackerwx"
  type = string
}

variable "environment" {
  default = "Test"
}

variable "codebuild_bucket_name" {
  default = "superb-codebuild-ci"
}

variable "codepipeline_bucket_name" {
  default = "superb-codepipeline-ci"
}

variable "code_build_project" {
  default = "superb-sre-challenge"
}
