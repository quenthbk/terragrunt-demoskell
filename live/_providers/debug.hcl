#
# This module does not configure providers;
# it returns input variables to outputs for verification purposes.
#
variable "aws_default_provider" {
  description = "Configure the AWS Default provider"
  type        = object({
    default_tags = optional(map(string), {})
    region       = string
    profile      = string
  })
}

variable "kubernetes_default_provider" {
  type = object({
    config_path    = string
    config_context = string
  })
}

output "aws_default_provider" {
  value = var.aws_default_provider
}

output "kubernetes_default_provider" {
  value = var.kubernetes_default_provider
}
