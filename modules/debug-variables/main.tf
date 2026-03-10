variable "env" {
  type = string
}

output "env" {
  value = var.env
}

# -----------------------

variable "module" {
  type = string
}

output "module" {
  value = var.module
}

# -----------------------

variable "region" {
  type = string
}

output "region" {
  value = var.region
}

# -----------------------

variable "main_dns_zone" {
  type = string
}

output "main_dns_zone" {
  value = var.main_dns_zone
}

# -----------------------

variable "public_accesses" {
  type = map(object({
    domain = string
  }))
}

output "public_accesses" {
  value = var.public_accesses
}
