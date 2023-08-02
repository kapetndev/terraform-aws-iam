resource "aws_iam_policy" "policy" {
  description = var.description
  name        = var.name
  policy      = var.policy
  tags        = var.tags
}

resource "aws_iam_group_policy_attachment" "groups" {
  for_each   = var.groups
  group      = each.value
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_role_policy_attachment" "roles" {
  for_each   = var.roles
  policy_arn = aws_iam_policy.policy.arn
  role       = each.value
}

resource "aws_iam_user_policy_attachment" "users" {
  for_each   = var.users
  policy_arn = aws_iam_policy.policy.arn
  user       = each.value
}
