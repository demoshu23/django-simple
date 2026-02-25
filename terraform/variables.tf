variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "django-eks"
}

variable "ecr_repository" {
  description = "Name of ECR repository for Django images"
  type        = string
  default     = "django-enterprise"
}