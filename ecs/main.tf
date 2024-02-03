# Creating ECS cluster
resource "aws_ecs_cluster" "cluster" {
  name = local.cluster-name

  tags = {
    Name        = local.cluster-name
    Project     = var.project
    Environment = var.environment
  }
}

# Creating role and policys necessarys to ECS task execution and attaching policys
resource "aws_iam_role" "task-execution-role" {
  name = local.task-execution-name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name        = local.task-execution-name
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_iam_policy" "policy" {
  name        = local.policy-name
  description = "Policy to allow create log groups in CloudWatch Logs"
  policy      = file("${path.module}/policy.json")

  tags = {
    Name        = local.policy-name
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "attachments" {
  for_each = {
    attachment-01 = { policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy" }
    attachment-02 = { policy_arn = aws_iam_policy.policy.arn }
  }

  role       = aws_iam_role.task-execution-role.id
  policy_arn = each.value.policy_arn
}

# Creating task definition
resource "aws_ecs_task_definition" "task-definition" {
  family                = local.task-definition-name
  container_definitions = file("${path.module}/task.json")
  execution_role_arn    = aws_iam_role.task-execution-role.arn
  cpu                   = var.cpu
  memory                = var.memory
  network_mode          = var.network-mode
}

# resource "aws_security_group" "alb_sg" {
#   vpc_id = "vpc-00000000000000000"

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_lb" "my_alb" {
#   name               = "my-alb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.alb_sg.id]
#   subnets            = ["subnet-00000000000000000", "subnet-00000000000000000"]
# }