# -----------------------

variable "aws_interface_private_links" {
  type    = set(string)
  default = [ ]
}

output "aws_interface_private_links" {
  value = var.aws_interface_private_links
}
