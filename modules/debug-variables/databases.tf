
# variable "databases" {
#   description = "List of databases"
#   type = map(object({
#     database = object({
#       name            = string
#       owner           = string
#       password_secret = string
#     })
#     namespace     = string
#     storage_size  = string
#     storage_class = string

#     wal_storage_size  = string
#     wal_storage_class = string

#     instances = optional(number, 1)
#     pooler    = optional(object({
#       instances = optional(number, 1)
#     }), {})

#     resources = optional(object({
#       limits = optional(object({
#         cpu    = optional(string, "100m")
#         memory = optional(string, "128Mi")
#       }), {})
#       requests = optional(object({
#         cpu    = optional(string, "50m")
#         memory = optional(string, "32Mi")
#       }), {})
#     }), {})
#   }))
# }

# output "databases" {
#   value = var.databases
# }
