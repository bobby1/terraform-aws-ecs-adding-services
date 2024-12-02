resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.environment}-${var.service}-webpage"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"] ### Options are "EC2" or "FARGATE"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name      = "${var.environment}-${var.service}-webpage"
      image     = "tomcat" ### Docker container options from Docker Hub include "nginx", "httpd", "tomcat"
      essential = true
      portMappings = [
        {
          containerPort = 8080 ### 80 for httpd and nginx, Tomcat default port 8080, other services may have different default ports
          hostPort      = 8080
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "wenorg-dev-ecs-cluster"
          "awslogs-region"        = "${var.region}"
          "awslogs-stream-prefix" = "ecs-frgt-New"
        }
      }
    }
  ])
}