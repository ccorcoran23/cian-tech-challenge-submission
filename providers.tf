terraform {
  required_version = ">= 1.6.0"

  # Provider we use pinned to vendor and version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Uses default region set in variables.tf
provider "aws" {
  region = var.aws_region
}
