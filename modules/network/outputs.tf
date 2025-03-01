output "private_subnets" {
  value = [for az in local.az_map : aws_subnet.public[az].id]
}

output "public_subnets" {
  value = [for az in local.az_map : aws_subnet.public[az].id]
}
