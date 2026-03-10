variable "storage_classes" {
  description = "Storage Classes to create"
  type = map(object({
    name                   = string
    parameters             = map(string)
    reclaim_policy         = string       # Retain | Delete
    storage_provisioner    = string
    volume_binding_mode    = string
    allow_volume_expansion = bool
  }))
}

output "storage_classes" {
  value = var.storage_classes
}
