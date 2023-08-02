# policy

Terraform module to create and manage Amazon Web Services IAM policies.

## Usage

See the [examples](../../examples) directory for working examples for reference:

```hcl
module "github_rds_policy" {
  source      = "git::https://github.com/kapetndev/terraform-aws-iam.git//modules/policy?ref=v0.1.0"
  name        = "github-rds-policy"
  description = "GitHub policy for RDS"
  policy      = file("./rds-admin.json")

  roles = [
    "github-rds-role",
  ]
}
```

## Examples

- [workload-identity](../../examples/workload-identity) - Create an IAM policy
  for a federated workload identity provider.

## Requirements

| Name | Version |
|------|---------|
| [terraform](https://www.terraform.io/) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| [aws](https://registry.terraform.io/providers/hashicorp/aws/latest) | >= 5.7.0 |

## Resources

| Name | Type |
|------|------|
| [`aws_iam_policy.policy`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [`aws_iam_group_policy_attachment.groups[*]`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [`aws_iam_role_policy_attachment.roles[*]`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [`aws_iam_user_policy_attachement.users[*]`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | A name for the policy. Changing this forces a new resource to be created | `string` | | yes |
| `policy` | The policy document in JSON format | `string` | | yes |
| `description` | A brief description of the policy | `string` | `null` | no |
| `groups` | A list of group names to which to assign the policy | `set(string)` | `[]` | no |
| `roles` | A list of role names to which to assign the policy | `set(string)` | `[]` | no |
| `tags` | A map of user defined key/value pairs to attach to the policy | `map(string)` | `null` | no |
| `users` | A list of users to which to assign the policy | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| `arn` | ARN of the policy |
