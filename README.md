# terraform-aws-iam ![policy](https://github.com/kapetndev/terraform-aws-iam/workflows/policy/badge.svg)

Terraform module to create and manage Amazon Web Services IAM resources.

## Examples

- [workload-identity](examples/workload-identity) - Create roles to be assumed
  through a federated workload identity provider.

## Requirements

| Name | Version |
|------|---------|
| [terraform](https://www.terraform.io/) | >= 1.0 |

## Modules

- [policy](modules/policy) - Create and manage an IAM policy.
- [workload\_identity\_provider](modules/workload_identity_provider) - Create
  and manage federated workload identity provider and roles to be assumed.
