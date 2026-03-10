include "root" {
  path = find_in_parent_folders()
}

include "environment" {
  path = "${dirname(find_in_parent_folders())}/_modules/${basename(get_terragrunt_dir())}.hcl"
}
