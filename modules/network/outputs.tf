output "subnet_ids" {
  value = [for az in local.az_map : aws_subnet.public[az].id]
}

output "vpc_id" {
  value = aws_vpc.default.id
}
