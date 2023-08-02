variable "allowed_audiences" {
  description = "A list of allowed audiences for the OIDC provider."
  type        = set(string)
}

variable "issuer_uri" {
  description = "The issuer URI for the OIDC provider."
  type        = string
}

variable "name" {
  description = "A name for the workload identity provider and assumed role. Changing this forces a new resource to be created."
  type        = string
}

variable "roles" {
  description = <<EOF
Roles to assume. Each role is assumed based on the conditions specified in the
role definition.

(Optional) description - A description of the role.
(Optional) conditions - The conditions to match for the role to be assumed.
EOF
  type = map(object({
    description = optional(string)
    conditions  = optional(any, {})
  }))
  default  = {}
  nullable = false
}

variable "tags" {
  description = "A map of user defined key/value pairs to attach to the workload identity provider."
  type        = map(string)
  default     = null
}
