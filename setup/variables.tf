variable "aws_region" {
  type        = string
  description = "The AWS region to create the role in."
}

variable "tf_organization" {
  type        = string
  description = "The name of the organization that this workspace and Stack live in."
}

variable "tf_project" {
  type        = string
  description = "The name of the project that this workspace and Stack live in."
}

variable "tf_stack" {
  type        = string
  description = "The name of the Stack you will you use this token in."
}
