data "aws_availability_zones" "available" {
  filter {
    name   = "region-name"
    values = [var.region]
  }
}

locals {
  subnets = [for cidr_block in cidrsubnets(var.cidr, 4, 4) : cidrsubnets(cidr_block, 4, 4)]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = var.name

  cidr = var.cidr
  azs  = slice(data.aws_availability_zones.available.names, 0, var.zone_count - 1)

  private_subnets = local.subnets[0]
  public_subnets  = local.subnets[1]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = var.tags
}
