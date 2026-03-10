locals {

  #############
  # VARIABLES #
  #############
  vpc_cidr             = "10.1.0.0/16"
  # newbits is the number of additional bits with which to extend the prefix.
  # For example, if given a prefix ending in /16 and a newbits value of 4,
  # the resulting subnet address will have length /20
  subnet_cidr_newbits = 3

  # netnum is a whole number that can be represented as a binary integer
  # with no more than newbits binary digits, which will be used to populate
  # the additional bits added to the prefix.
  public_subnet_net_nums = [0, 1, 2]
  private_subnet_net_nums = [3, 4, 5]

  ###########
  # IMPORTS #
  ###########
  main = read_terragrunt_config("main.hcl").inputs

  availability_zones = try(local.main.region_vars.availability_zones, [])

  public_subnet_count  = try(local.main.env_vars.network.public_subnet_count, 0)
  private_subnet_count = try(local.main.env_vars.network.private_subnet_count, 0)

  # Public Subnet
  available_public_subnet_cidrs = [
  for netnum in local.public_subnet_net_nums: cidrsubnet(
    local.vpc_cidr,
    local.subnet_cidr_newbits,
    netnum
  )]
  public_subnets = {
    for az in slice(local.availability_zones, 0, local.public_subnet_count):
      "${az}-public" => {
        cidr_block        = local.available_public_subnet_cidrs[index(local.availability_zones, az)]
        availability_zone = az
      }
  }

  # Private Subnet
  available_private_subnet_cidrs = [
  for netnum in local.private_subnet_net_nums : cidrsubnet(
    local.vpc_cidr,
    local.subnet_cidr_newbits,
    netnum
  )]
  private_subnets = {
    for az in slice(local.availability_zones, 0, local.private_subnet_count):
      "${az}-private" => {
        cidr_block        = local.available_private_subnet_cidrs[index(local.availability_zones, az)]
        availability_zone = az
      }
  }
}

inputs = {
  vpc_cidr           = local.vpc_cidr
  public_subnets     = local.public_subnets
  private_subnets    = local.private_subnets
  availability_zones = local.availability_zones
}
