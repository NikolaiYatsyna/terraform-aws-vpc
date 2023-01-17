data "aws_availability_zones" "available" {
  filter {
    name   = "region-name"
    values = [var.region]
  }
}

locals {
  available_zones_count = length(data.aws_availability_zones.available.names)
  zone_count      = var.zone_count < local.available_zones_count ? var.zone_count : local.available_zones_count
  range           = cidrsubnets(var.cidr, [for i in range(local.available_zones_count * 2) : 8]...)
  private_subnets = slice(local.range, 0, local.zone_count)
  public_subnets  = reverse(slice(reverse(local.range), 0, local.zone_count))
}

module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  name                 = var.name

  cidr                 = var.cidr
  azs                  = slice(data.aws_availability_zones.available.names, 0, local.zone_count - 1)
  private_subnets      = local.private_subnets
  public_subnets       = local.public_subnets
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  tags = var.tags
}
