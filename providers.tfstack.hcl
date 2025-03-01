required_providers {
  aws = {
    source = "hashicorp/aws"
    version = ">= 5.89.0"
  }
}

provider "aws" "all" {
  for_each = var.configurations
  
  config {
    region = each.key

    assume_role_with_web_identity {
      role_arn           = var.role_arn
      web_identity_token = var.identity_token
    }
  }
}