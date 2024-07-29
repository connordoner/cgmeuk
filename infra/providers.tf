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

# AWS configuration for the UK
provider "aws" {
  region = "eu-west-2"
  
  default_tags {
    tags = {
      "connorgurney:workload"    = "cgmeuk"
      "connorgurney:environment" = "production"
    }
  }
}

# AWS configuration for the USA
# This is used to create my SSL and TLS certificates as Amazon CloudFront requires that they be hosted there
provider "aws" {
  alias  = "us"
  region = "us-east-1"
  
  default_tags {
    tags = {
      "connorgurney:workload"    = "cgmeuk"
      "connorgurney:environment" = "production"
    }
  }
}
