# Terraform configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5"
    }
  }
}

# AWS provider configuration
provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      "connorgurney:workload"    = "cgmeuk"
      "connorgurney:environment" = var.environment
    }
  }
}
