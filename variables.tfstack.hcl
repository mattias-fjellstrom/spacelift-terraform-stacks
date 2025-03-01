variable "configurations" {
  description = "AWS regions to deploy infrastructure in"
  type = map(object({
    cidr_block = string
  }))
}

variable "environment" {
  description = "Application environment name"
  type        = string
}

variable "identity_token" {
  description = "Token for authorization to AWS"
  type        = string
  ephemeral   = true
}

variable "role_arn" {
  description = "Role ARN for authorization to AWS"
  type        = string
}
