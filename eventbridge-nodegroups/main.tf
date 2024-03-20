# Retrieving account id
data "aws_caller_identity" "current" {}

# Retrieving region
data "aws_region" "current" {}

# Creating policy to be used by lambda role
data "template_file" "lambda-policy" {
  template = file("${path.module}/lambda-policy.json")

  vars = {
    region                = data.aws_region.current.name
    account               = data.aws_caller_identity.current.account_id
    cluster-name          = var.cluster-name
    lambda-scaleup-name   = local.lambda-scaleup-name
    lambda-scaledown-name = local.lambda-scaledown-name
  }
}

resource "aws_iam_policy" "lambda-policy" {
  name   = local.lambda-policy-name
  policy = data.template_file.lambda-policy.rendered

  tags = {
    name        = local.lambda-policy-name
    project     = var.project
    environment = var.environment
  }
}

# Creating role to be used by lambda and attaching policys
resource "aws_iam_role" "lambda-role" {
  name = local.lambda-role-name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    name        = local.lambda-role-name
    project     = var.project
    environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "lambda-attachment" {
  role       = aws_iam_role.lambda-role.name
  policy_arn = aws_iam_policy.lambda-policy.arn
}

# Creating lambda functions
data "archive_file" "lambda" {
  for_each = {
    scaleup   = { source_file = "${path.module}/scaleup.py", output_path = "scaleup.zip" }
    scaledown = { source_file = "${path.module}/scaledown.py", output_path = "scaledown.zip" }
  }

  type        = "zip"
  source_file = each.value.source_file
  output_path = each.value.output_path
}

resource "aws_lambda_function" "lambda" {
  for_each = {
    scaleup   = { function_name = local.lambda-scaleup-name, handler = "scaleup.lambda_handler", filename = "scaleup.zip" }
    scaledown = { function_name = local.lambda-scaledown-name, handler = "scaledown.lambda_handler", filename = "scaledown.zip" }
  }

  function_name = each.value.function_name
  handler       = each.value.handler
  filename      = each.value.filename
  runtime       = var.lambda-runtime
  timeout       = var.lambda-timeout
  role          = aws_iam_role.lambda-role.arn

  environment {
    variables = {
      region_name  = data.aws_region.current.name
      cluster_name = var.cluster-name
    }
  }

  tags = {
    name        = each.value.function_name
    project     = var.project
    environment = var.environment
  }
}

# Creating policy to be used by eventbridge role
data "template_file" "eventbridge-policy" {
  template = file("${path.module}/eventbridge-policy.json")

  vars = {
    region                = data.aws_region.current.name
    account               = data.aws_caller_identity.current.account_id
    scaleup-lambda-name   = local.lambda-scaleup-name
    scaledown-lambda-name = local.lambda-scaledown-name
  }
}

resource "aws_iam_policy" "eventbridge-policy" {
  name   = local.eventbridge-policy-name
  policy = data.template_file.eventbridge-policy.rendered

  tags = {
    name        = local.eventbridge-policy-name
    project     = var.project
    environment = var.environment
  }
}

# Creating role to be used by eventbridge and attaching policys
resource "aws_iam_role" "eventbridge-role" {
  name = local.eventbridge-role-name
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "scheduler.amazonaws.com"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {
          "StringEquals" : {
            "aws:SourceAccount" : data.aws_caller_identity.current.account_id
          }
        }
      }
    ]
  })

  tags = {
    name        = local.eventbridge-role-name
    project     = var.project
    environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "eventbridge-attachment" {
  role       = aws_iam_role.eventbridge-role.name
  policy_arn = aws_iam_policy.eventbridge-policy.arn
}

# Creating scheduler to trigger lambda
resource "aws_scheduler_schedule" "schedulers" {
  for_each = {
    scaleup   = { name = local.scheduler-scaleup-name, schedule_expression = var.cron-scaleup }
    scaledown = { name = local.scheduler-scaledown-name, schedule_expression = var.cron-scaledown }
  }

  name                         = each.value.name
  schedule_expression          = each.value.schedule_expression
  schedule_expression_timezone = var.timezone

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = local.lambda-targets[each.key]
    role_arn = aws_iam_role.eventbridge-role.arn
  }
}