variable "configurations" {
  description = "Map of AWS region name to its configuration"
  type = map(object({
    cidr_block = string
  }))
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
