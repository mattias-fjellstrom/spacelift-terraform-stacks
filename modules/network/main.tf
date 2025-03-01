resource "aws_vpc" "default" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "vpc-${var.aws_region}"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs    = data.aws_availability_zones.available.names
  az_map = zipmap(local.azs, range(length(local.azs)))
}

resource "aws_subnet" "public" {
  for_each = local.az_map

  vpc_id            = aws_vpc.default.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, each.value * 2)
  availability_zone = each.key

  tags = {
    Name = "public-subnet-${each.key}"
  }
}

resource "aws_subnet" "private" {
  for_each = local.az_map

  vpc_id            = aws_vpc.default.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, each.value * 2 + 1)
  availability_zone = each.key

  tags = {
    Name = "private-subnet-${each.key}"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "igw-${var.aws_region}"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "eip-natgw-${var.aws_region}"
  }
}

resource "aws_nat_gateway" "default" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[local.azs[0]].id

  tags = {
    Name = "natgw-${var.aws_region}"
  }

  depends_on = [
    aws_internet_gateway.default,
  ]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block       = var.vpc_cidr_block
    local_gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "rt-public-${var.aws_region}"
  }
}

resource "aws_route_table_association" "public" {
  for_each       = local.az_map
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[each.key].id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block       = var.vpc_cidr_block
    local_gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.default.id
  }

  tags = {
    Name = "rt-private-${var.aws_region}"
  }
}

resource "aws_route_table_association" "private" {
  for_each       = local.az_map
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private[each.key].id
}
