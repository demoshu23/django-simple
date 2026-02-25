module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.0.1"

  name    = var.cluster_name      # <- was cluster_name
  version = "1.29"                # <- was cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 5
      min_capacity     = 2
      instance_types   = ["t3.medium"]
    }
  }
}