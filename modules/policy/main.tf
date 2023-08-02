resource "aws_iam_policy" "policy" {
  name        = var.name
  description = var.description
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
  role       = each.value
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_user_policy_attachment" "users" {
  for_each   = var.users
  user       = each.value
  policy_arn = aws_iam_policy.policy.arn
}
