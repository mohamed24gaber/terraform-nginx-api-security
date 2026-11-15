resource "aws_ssm_parameter" "internal_token" {
  name             = "/nginx-api-security/internal-token"
  description      = "Internal token for NGINX API Gateway authorization"
  type             = "SecureString"
  value_wo         = var.internal_token
  value_wo_version = 1

  tags = {
    Project = "NGINX-API-Security"
  }
}


