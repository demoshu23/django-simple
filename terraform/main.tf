module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.1.0" # module version (Terraform registry)

  name            = var.cluster_name
  cluster_version = "1.29" # Kubernetes cluster version

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

  tags = {
    Environment = "production"
    Project     = "django"
  }
}