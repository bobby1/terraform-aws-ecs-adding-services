resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.environment}-${var.service}-tsk-${var.app_port}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"] ### Options are "EC2" or "FARGATE"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name      = "${var.environment}-${var.service}-tsk-${var.app_port}"
      image     = var.app_image ### Image repository URL
      essential = true
      portMappings = [
        {
          containerPort = var.app_port
          hostPort      = var.app_port
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          # "awslogs-group"         = "/${business_division}/${var.environment}-${var.service}-cluster"
          "awslogs-group"         = "/${var.environment}/${var.service}-cluster"
          "awslogs-region"        = "${var.region}"
          "awslogs-stream-prefix" = "${var.environment}-${var.service}"
        }
      }
    }
  ])
}