data "tls_certificate" "issuer_certificate" {
  url = var.issuer_uri
}

resource "aws_iam_openid_connect_provider" "identity_provider" {
  client_id_list = var.allowed_audiences
  tags           = merge({ "Name" = var.name }, var.tags)
  url            = data.tls_certificate.issuer_certificate.url

  thumbprint_list = [
    data.tls_certificate.issuer_certificate.certificates[0].sha1_fingerprint,
  ]
}

resource "aws_iam_role" "roles" {
  for_each    = var.roles
  description = each.value.description
  name        = each.key
  tags        = var.tags

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRoleWithWebIdentity",
     "Condition": ${jsonencode(each.value.conditions)},
     "Effect": "Allow",
     "Principal": {
       "Federated": "${aws_iam_openid_connect_provider.identity_provider.arn}"
     }
   }
 ]
}
EOF
}
