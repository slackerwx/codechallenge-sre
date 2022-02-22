module "eks" {
  source = "registry.terraform.io/terraform-aws-modules/eks/aws"
  version = "17.24.0"
  cluster_name = local.cluster_name
  cluster_version = "1.21"
  subnets = module.vpc.public_subnets

  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name = "worker-group-1"
      instance_type = "t2.small"
      additional_security_groups_ids = [aws_security_group.worker_group_mgmt_one.id]
      asg_desired_capacity = 1
    }
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

