
variable "vpc_cidr" {
  type = string
}

output "vpc_cidr" {
  value = var.vpc_cidr
}

# -----------------------

variable "public_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

output "public_subnets" {
  value = var.public_subnets
}

# -----------------------

variable "private_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

output "private_subnets" {
  value = var.private_subnets
}

# -----------------------

variable "availability_zones" {
  type = set(string)
}

output "availability_zones" {
  value = var.availability_zones
}
