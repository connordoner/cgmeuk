# Terraform configuration
terraform {
  cloud {
    organization = "connorgurney"

    workspaces {
      name = "cgmeuk"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS configuration
provider "aws" {
  region = "eu-west-2"
  
  default_tags {
    tags = {
      "connorgurney:workload"    = "cgmeuk"
      "connorgurney:environment" = "production"
    }
  }
}
