terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.89.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "0.64.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "tfe" {
  organization = var.tf_organization
}
