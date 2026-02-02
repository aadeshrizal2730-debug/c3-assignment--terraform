resource "aws_ssm_parameter" "db_password" {
  name  = "/app/db/password"
  type  = "SecureString"
  value = "ChangeMe123!"
}

