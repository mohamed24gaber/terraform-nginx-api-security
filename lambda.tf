resource "aws_lambda_function" "authorizer" {
  function_name = "nginx-api-header-authorizer"
  role          = "arn:aws:iam::744239591708:role/PowerUserRole"
  handler       = "index.handler"
  runtime       = "nodejs26.x"
  timeout       = 3
  memory_size   = 128
  architectures = ["x86_64"]

  filename         = "${path.module}/lambda-authorizer.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda-authorizer.zip")

  lifecycle {
    ignore_changes = [
      environment,
      filename,
      source_code_hash
    ]
  }
}

resource "aws_lambda_function" "backend" {
  function_name = "nginx-api-users-backend"
  role          = "arn:aws:iam::744239591708:role/PowerUserRole"
  handler       = "index.handler"
  runtime       = "nodejs26.x"
  timeout       = 3
  memory_size   = 128
  architectures = ["x86_64"]

  filename         = "${path.module}/lambda-backend.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda-backend.zip")

  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash
    ]
  }
}
