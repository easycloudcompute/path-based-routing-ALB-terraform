# Terraform Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.4.0"
    }

    # Random provider is used to generate random values (like strings, numbers, or UUIDs) that can be used anywhere, including in AWS resources.
    random = {
      source = "hashicorp/random"
      # version = "~> 3.0"
    }
  }
}

# Provider Block
provider "aws" {
  region = var.aws_region
}

# Create Random Pet Resource
resource "random_pet" "this" { # Generates human-readable names
  length = 2
}