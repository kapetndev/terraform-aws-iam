data "tls_certificate" "issuer_certificate" {
  url = var.issuer_uri
}

resource "aws_iam_openid_connect_provider" "identity_provider" {
  url            = data.tls_certificate.issuer_certificate.url
  client_id_list = var.allowed_audiences
  tags           = merge({ "Name" = var.name }, var.tags)

  thumbprint_list = [
    data.tls_certificate.issuer_certificate.certificates[0].sha1_fingerprint,
  ]
}

resource "aws_iam_role" "roles" {
  for_each    = var.roles
  name        = each.key
  description = each.value.description
  tags        = var.tags

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Effect": "Allow",
     "Principal": {
       "Federated": "${aws_iam_openid_connect_provider.identity_provider.arn}"
     },
     "Action": "sts:AssumeRoleWithWebIdentity",
     "Condition": ${jsonencode(each.value.conditions)}
   }
 ]
}
EOF
}
