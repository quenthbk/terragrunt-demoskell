locals {
  storage_classes = {
    "gp3" = {
      name                   = "gp3"
      storage_provisioner    = "kubernetes.io/aws-ebs"
      reclaim_policy         = "Delete" # @TODO - Change to retain in production ?
      volume_binding_mode    = "WaitForFirstConsumer"
      allow_volume_expansion = true

      parameters  = {
        "type"   = "gp3" # The type of EBS volume. Adjust if you need "io1", "st1", etc.
        "fsType" = "ext4"
      }
    }
  }
}

inputs = {
  storage_classes = local.storage_classes
}
