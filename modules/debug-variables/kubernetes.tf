variable "k8s_namespaces" {
  type = map(object({
    name = string
  }))
}

output "k8s_namespaces" {
  value = var.k8s_namespaces
}

# -----------------------

variable "k8s_labels" {
  type = map(string)
}

output "k8s_labels" {
  value = var.k8s_labels
}

# -----------------------
