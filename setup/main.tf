resource "aws_iam_openid_connect_provider" "stacks_openid_provider" {
  url             = "https://app.terraform.io"
  client_id_list  = ["aws.workload.identity"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
}

resource "aws_iam_role" "stacks_role" {
  name               = "spacelift-demo"
  assume_role_policy = data.aws_iam_policy_document.stacks_role_policy.json
}

resource "tfe_project" "spacelift" {
  name        = var.tf_project
  description = "Terraform stacks demo for Spacelift blog post"
}

data "aws_iam_policy_document" "stacks_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.stacks_openid_provider.arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "app.terraform.io:aud"
      values   = ["aws.workload.identity"]
    }
    condition {
      test     = "StringLike"
      variable = "app.terraform.io:sub"
      values   = ["organization:${var.tf_organization}:project:${var.tf_project}:stack:${var.tf_stack}:*"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "iam" {
  role       = aws_iam_role.stacks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
