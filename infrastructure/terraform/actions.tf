locals {
  actions_version       = "1.0.0"
  actions_handler_class = "org.realworld.actions.Application"
  http4k_handler        = "org.http4k.serverless.lambda.LambdaFunction::handle"
  actions_jar_location  = "../../backend/actions/build/libs/actions-server-${local.actions_version}-all.jar"
  actions_function_name = "actions_handler"
  actions_api_url       = aws_api_gateway_deployment.actions_api.invoke_url
}

resource "aws_lambda_function" "actions_handler" {
  function_name = local.actions_function_name
  handler       = local.http4k_handler
  filename      = local.actions_jar_location
  role          = aws_iam_role.lambda_role.arn
  memory_size   = 512
  timeout       = 20
  runtime       = "java8"
  environment {
    variables = {
      ACTIONS_SECRET              = random_password.actions_secret.result
      HASURA_GRAPHQL_URL          = local.hasura_app_graphql_url
      HASURA_GRAPHQL_ADMIN_SECRET = random_password.admin_secret.result
      HASURA_GRAPHQL_JWT_SECRET   = random_password.jwt_secret.result
      HTTP4K_BOOTSTRAP_CLASS      = local.actions_handler_class
      VERSION                     = local.actions_version
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "actions_handler_lambda"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect    = "Allow",
        Sid       = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach-lambda-execution-role" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = data.aws_iam_policy.LambdaExecution.arn
}

data "aws_iam_policy" "LambdaExecution" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_api_gateway_rest_api" "actions_api" {
  name        = "ActionsApi"
  description = "Api Gateway for actions server"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.actions_api.id
  parent_id   = aws_api_gateway_rest_api.actions_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  authorization = "NONE"
  http_method   = "ANY"
  resource_id   = aws_api_gateway_resource.proxy.id
  rest_api_id   = aws_api_gateway_rest_api.actions_api.id
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.actions_api.id
  resource_id = aws_api_gateway_method.proxy.resource_id
  http_method = aws_api_gateway_method.proxy.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.actions_handler.invoke_arn
}

resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = aws_api_gateway_rest_api.actions_api.id
  resource_id   = aws_api_gateway_rest_api.actions_api.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = aws_api_gateway_rest_api.actions_api.id
  resource_id = aws_api_gateway_method.proxy_root.resource_id
  http_method = aws_api_gateway_method.proxy_root.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.actions_handler.invoke_arn
}

resource "aws_api_gateway_deployment" "actions_api" {
  depends_on = [
    aws_api_gateway_integration.lambda,
    aws_api_gateway_integration.lambda_root,
  ]

  rest_api_id = aws_api_gateway_rest_api.actions_api.id
  stage_name  = "dev"
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.actions_handler.function_name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.actions_api.execution_arn}/*/*"
}