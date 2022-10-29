data "aws_caller_identity" "current-user" {}

resource "aws_secretsmanager_secret_policy" "secret-policy" {
  secret_arn = aws_secretsmanager_secret.secretmasterDB.arn

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EnableAnotherAWSAccountToReadTheSecret",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${data.aws_caller_identity.current-user.arn}"
      },
      "Action": "secretsmanager:GetSecretValue",
      "Resource": "*"
    }
  ]
}
POLICY
}