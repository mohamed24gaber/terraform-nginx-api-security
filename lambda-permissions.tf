resource "aws_lambda_permission" "authorizer_apigateway" {
  statement_id  = "69cc435a-8598-5f1e-9498-e8cf398e06e3"
  action        = "lambda:InvokeFunction"
  function_name = "nginx-api-header-authorizer"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:eu-north-1:744239591708:8ihy6zxl78/authorizers/mxn2m4"
}

resource "aws_lambda_permission" "backend_apigateway" {
  statement_id  = "0c39ad2e-10af-54fe-b6fc-403b11239780"
  action        = "lambda:InvokeFunction"
  function_name = "nginx-api-users-backend"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:eu-north-1:744239591708:8ihy6zxl78/*/*/users"
}
