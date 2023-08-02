variable "description" {
  description = "A brief description of the policy."
  type        = string
  default     = null
}

variable "groups" {
  description = "A list of group names to which to assign the policy."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "name" {
  description = "A name for the policy. Changing this forces a new resource to be created."
  type        = string
}

variable "policy" {
  description = "The policy document in JSON format."
  type        = string
}

variable "roles" {
  description = "A list of role names to which to assign the policy."
  type        = set(string)
  default     = []
  nullable    = false
}

variable "tags" {
  description = "A map of user defined key/value pairs to attach to the policy."
  type        = map(string)
  default     = null
}

variable "users" {
  description = "A list of users to which to assign the policy."
  type        = set(string)
  default     = []
  nullable    = false
}
