module "github_actions_identity_provider" {
  source            = "git::https://github.com/kapetndev/terraform-aws-iam.git//modules/workload_identity_provider?ref=v0.1.0"
  name              = "github-provider"
  issuer_uri        = "https://token.actions.githubusercontent.com"
  allowed_audiences = var.allowed_audiences

  roles = {
    "github-rds-role" = {
      conditions = {
        "StringEquals" = {
          "token.actions.githubusercontent.com:aud" = one(var.allowed_audiences)
        },
        "StringLike" = {
          "token.actions.githubusercontent.com:sub" = "${var.github_organization}/*"
        },
      }
      description = "GitHub role to provision RDS instances"
    }
  }
}

module "github_rds_policy" {
  source      = "git::https://github.com/kapetndev/terraform-aws-iam.git//modules/policy?ref=v0.1.0"
  name        = "github-rds-policy"
  description = "GitHub policy for RDS"
  policy      = file("./rds-admin.json")

  roles = [
    "github-rds-role",
  ]
}
