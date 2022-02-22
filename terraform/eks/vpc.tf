variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "superb-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}


module "vpc" {
  source = "registry.terraform.io/terraform-aws-modules/vpc/aws"

  name                 = "superb-vpc"
  public_subnets       = [var.cidr_subnet_public]
  cidr                 = var.cidr_vpc
  azs                  = data.aws_availability_zones.available.names
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = true
  single_nat_gateway   = true
}

