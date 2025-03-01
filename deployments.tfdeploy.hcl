locals {
  base_cidr = "10.0.0.0/16"
  role_arn  = "arn:aws:iam::629138043200:role/spacelift-demo"
}

identity_token "aws" {
  audience = ["aws.workload.identity"]
}

deployment "dev" {
  inputs = {
    configurations = {
      "eu-west-1" = {
        cidr_block = cidrsubnet(local.base_cidr, 4, 0)
      }
      "eu-west-2" = {
        cidr_block = cidrsubnet(local.base_cidr, 4, 1)
      }
      "eu-west-3" = {
        cidr_block = cidrsubnet(local.base_cidr, 4, 2)
      }
    }
    environment    = "dev"
    identity_token = identity_token.aws.jwt
    role_arn       = local.role_arn
  }
}