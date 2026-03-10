#
# The root terragrunt file is the bootstrap of terragrunt command.
#
locals {
  ###########
  # IMPORTS #
  ###########
  root_dir = get_parent_terragrunt_dir("root")

  main      = read_terragrunt_config("${local.root_dir}/_variables/main.hcl").inputs

  provider = split("-", local.main.module)[0]

  # The backend gitlab api to save terraform states
  gitlab_host   = "https://gitlab.lan.example.fr/api/v4/projects/3041/terraform/state"
  tf_state_name = "${local.main.region}-${local.main.env}-${local.main.module}"

  # Different backend configuration
  backend_config = {
    # Remote gitlab backend config block (default)
    gitlab = {
      address        = "${local.gitlab_host}/${local.tf_state_name}"
      lock_address   = "${local.gitlab_host}/${local.tf_state_name}/lock"
      unlock_address = "${local.gitlab_host}/${local.tf_state_name}/lock"
      lock_method    = "POST"
      unlock_method  = "DELETE"
      retry_wait_min = 5
    }

    # Local backend config block for dev and test purpose
    local = {}
  }
}

####################
# Terraform Config #
####################
terraform {
  # Module to call
  source = "${local.root_dir}/../modules/${local.main.module}//"
}

#####################
# Generic Providers #
#####################

# The default generated providers.tf
generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = file("${local.root_dir}/_providers/${local.provider}.hcl")
}

###########
# BACKEND #
###########

remote_state {
  # The choice of backend is made based on the region
  backend = local.main.region == "local" ? "local" : "http"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = local.main.region == "local" ? local.backend_config.local : local.backend_config.gitlab
}

######################
# VARIABLE INJECTION #
######################

# Merge input from other terragrunt files.
inputs = merge(
  local.main,
  read_terragrunt_config("${local.root_dir}/_variables/versions.hcl").inputs,
  read_terragrunt_config("${local.root_dir}/_variables/network.hcl").inputs,
  read_terragrunt_config("${local.root_dir}/_variables/aws.hcl").inputs,
  read_terragrunt_config("${local.root_dir}/_variables/storage.hcl").inputs,
  read_terragrunt_config("${local.root_dir}/_variables/kubernetes.hcl").inputs
)
