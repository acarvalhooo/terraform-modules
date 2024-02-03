# Cluster name
locals {
  cluster-name = "ecs-cluster-${var.project}-${var.environment}"
}

# Task execution name
locals {
  task-execution-name = "ECSTaskExecutionRole-${var.project}-${var.environment}"
}

# CloudWatch policy name
locals {
  policy-name = "CreateLogGroupPolicy-${var.project}-${var.environment}"
}

# Task definition name
locals {
  task-definition-name = "TaskDefinition-${var.project}-${var.environment}"
}