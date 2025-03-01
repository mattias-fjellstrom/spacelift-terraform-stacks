output "subnet_ids" {
  value = [for k, v in aws_subnet.public : v.id]
}

output "vpc_id" {
  value = aws_vpc.default.id
}
