locals {
  ##################
  # MAIN VARIABLES #
  ##################
  owner          = "Example"
  project_name   = "my"
  production     = "prd01"
  main_dns_zone  = "my-cloud.example.fr"

  ######################
  # COMPUTED VARIABLES #
  ######################
  # Return [{module}, {env}, {region}, ...]
  reverse_path = reverse(split("/", get_original_terragrunt_dir()))
  module       = local.reverse_path[0]
  env          = local.reverse_path[1]
  region       = local.reverse_path[2]

  public_accesses = {
    "app2" = {
      domain = "app2.${local.main_dns_zone}"
    }
    "app1" = {
      domain = "app1.${local.main_dns_zone}"
    }
  }

  ######################
  # IMPORTED VARIABLES #
  ######################
  region_vars = read_terragrunt_config("${get_original_terragrunt_dir()}/../../region.hcl").inputs
  env_vars    = read_terragrunt_config("${get_original_terragrunt_dir()}/../env.hcl").inputs
}

inputs = {
  env                    = local.env
  module                 = local.module
  region                 = local.region
  project_name           = local.project_name
  main_dns_zone          = local.main_dns_zone
  owner                  = local.owner
  public_accesses        = local.public_accesses
  region_vars            = local.region_vars
  env_vars               = local.env_vars
}
