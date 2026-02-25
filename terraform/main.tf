provider "aws" {
  region = var.aws_region
}

# ---------------------
# VPC Module
# ---------------------
data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name            = "django-vpc"
  cidr            = "10.0.0.0/16"
  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = "production"
    Project     = "django"
  }
}

# ---------------------
# EKS Cluster
# ---------------------
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.1.0"

  cluster_name    = var.cluster_name
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

# ---------------------
# ECR Repository
# ---------------------
resource "aws_ecr_repository" "django" {
  name = var.ecr_repository
}