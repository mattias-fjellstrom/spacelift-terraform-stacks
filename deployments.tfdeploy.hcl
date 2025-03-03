locals {
  role_arn  = "arn:aws:iam::629138043200:role/spacelift-demo"
}

identity_token "aws" {
  audience = ["aws.workload.identity"]
}

deployment "dev" {
  inputs = {
    configurations = {
      "eu-west-1" = {
        cidr_block = "10.0.0.0/20"
      }
      "eu-west-2" = {
        cidr_block = "10.0.16.0/20"
      }
      "eu-west-3" = {
        cidr_block = "10.0.32.0/20"
      }
    }
    identity_token = identity_token.aws.jwt
    role_arn       = local.role_arn
  }
}

deployment "stage" {
  inputs = {
    configurations = {
      "eu-west-1" = {
        cidr_block = "10.100.0.0/20"
      }
      "eu-west-2" = {
        cidr_block = "10.100.16.0/20"
      }
      "eu-west-3" = {
        cidr_block = "10.100.32.0/20"
      }
    }
    identity_token = identity_token.aws.jwt
    role_arn       = local.role_arn
  }
}

deployment "prod" {
  inputs = {
    configurations = {
      "eu-west-1" = {
        cidr_block = "10.200.0.0/20"
      }
      "eu-west-2" = {
        cidr_block = "10.200.16.0/20"
      }
      "eu-west-3" = {
        cidr_block = "10.200.32.0/20"
      }
    }
    identity_token = identity_token.aws.jwt
    role_arn       = local.role_arn
  }
}