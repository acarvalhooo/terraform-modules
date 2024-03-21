# Lambda name for scale up
locals {
  lambda-scaleup-name = "ScaleUpNodeGroups-${var.project}-${var.environment}"
}

# Lambda name for scale down
locals {
  lambda-scaledown-name = "ScaleDownNodeGroups-${var.project}-${var.environment}"
}

# Lambda policy name
locals {
  lambda-policy-name = "AmazonAdjustNodeGroupSizePolicy-${var.project}-${var.environment}"
}

# Role name
locals {
  lambda-role-name = "AmazonAdjustNodeGroupSizeRole-${var.project}-${var.environment}"
}

# Eventbridge policy name
locals {
  eventbridge-policy-name = "AmazonInvokeLambdaFunctionPolicy-${var.project}-${var.environment}"
}

# Eventbridge role name
locals {
  eventbridge-role-name = "AmazonInvokeLambdaFunctionRole-${var.project}-${var.environment}"
}

# Scheduler scale up name
locals {
  scheduler-scaleup-name = "SchedulerScaleUp-${var.project}-${var.environment}"
}

# Scheduler scale down name
locals {
  scheduler-scaledown-name = "SchedulerScaleDown-${var.project}-${var.environment}"
}

# Mapping targets of schedulers
locals {
  lambda-targets = {
    scaleup   = aws_lambda_function.lambda["scaleup"].arn
    scaledown = aws_lambda_function.lambda["scaledown"].arn
  }
}