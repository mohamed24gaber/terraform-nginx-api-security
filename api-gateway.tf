resource "aws_apigatewayv2_api" "nginx_api" {
  name                         = "nginx-api-security"
  protocol_type                = "HTTP"
  api_key_selection_expression = "$request.header.x-api-key"
}

resource "aws_apigatewayv2_integration" "users_backend" {
  api_id                 = aws_apigatewayv2_api.nginx_api.id
  description            = "Users backend Lambda integration"
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  integration_uri        = "arn:aws:lambda:eu-north-1:744239591708:function:nginx-api-users-backend"
  payload_format_version = "2.0"
  timeout_milliseconds   = 30000
}

resource "aws_apigatewayv2_authorizer" "header_authorizer" {
  api_id                            = aws_apigatewayv2_api.nginx_api.id
  name                              = "nginx-header-authorizer"
  authorizer_type                   = "REQUEST"
  authorizer_uri                    = "arn:aws:apigateway:eu-north-1:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-north-1:744239591708:function:nginx-api-header-authorizer/invocations"
  authorizer_payload_format_version = "2.0"
  authorizer_result_ttl_in_seconds  = 0
  enable_simple_responses           = true
  identity_sources                  = ["$context.routeKey"]
}

resource "aws_apigatewayv2_route" "users" {
  api_id             = aws_apigatewayv2_api.nginx_api.id
  route_key          = "GET /users"
  authorization_type = "CUSTOM"
  authorizer_id      = aws_apigatewayv2_authorizer.header_authorizer.id
  target             = "integrations/${aws_apigatewayv2_integration.users_backend.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.nginx_api.id
  name        = "$default"
  auto_deploy = true
}
