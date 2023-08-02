# workload\_identity\_provider

Terraform module to create and manage Amazon Web Services IAM OpenID Connect
providers.

## Usage

See the [examples](../../examples) directory for working examples for reference:

```hcl
module "github_action_identity_provider" {
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
```

## Requirements

| Name | Version |
|------|---------|
| [terraform](https://www.terraform.io/) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| [aws](https://registry.terraform.io/providers/hashicorp/aws/latest) | >= 5.7.0 |
| [tls](https://registry.terraform.io/providers/hashicorp/tls/latest) | >= 4.0.4 |

## Resources

| Name | Type |
|------|------|
| [`tls_certificate.issuer_certificate`](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data |
| [`aws_iam_openid_connect_provider.identity_provider`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [`aws_iam_role.roles[*]`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `allowed_audiences` | A list of allowed audiences for the OIDC provider | `string` | | yes |
| `issuer_uri` | The issue URL for the OIDC provider | `string` | | yes |
| `name` | A name for the workload identity provider and assumed role. Changing this forces a new resource to be created | `string` | | yes |
| `roles` | Roles to assume. Each role is assumed based on the conditions specified in the role definition | `map(object{...})` | `{}` | no |
| `roles[*].description` | A description of the role | `string` | `null` | no |
| `roles[*].conditions` | The conditions to match for the role to be assumed | `any` | `{}` | no |
| `tags` | A map of user defined key/value pairs to attach to the workload identity provider | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| `role_arns` | ARN of the IAM roles |
