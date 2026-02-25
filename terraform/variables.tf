variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "django-eks"
}

variable "ecr_repository" {
  description = "ECR repository name"
  type        = string
  default     = "django-enterprise"
}