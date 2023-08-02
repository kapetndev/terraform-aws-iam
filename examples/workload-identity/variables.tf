variable "allowed_audiences" {
  description = "Allowed audiences for the OIDC provider."
  type        = set(string)
}

variable "github_organization" {
  description = "The name of the GitHub organization for identity federation."
  type        = string
}
