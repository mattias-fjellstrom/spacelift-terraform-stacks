component "network" {
  for_each = var.configurations

  source = "./modules/network"

  inputs = {
    aws_region     = each.key
    vpc_cidr_block = each.value.cidr_block
  }

  providers = {
    aws = provider.aws.all[each.key]
  }
}

component "compute" {
  for_each = var.configurations

  source = "./modules/compute"

  inputs = {
    subnet_ids = component.network[each.key].subnet_ids
  }

  providers = {
    aws = provider.aws.all[each.key]
  }
}