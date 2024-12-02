resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.environment}-${var.service}-webpage"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  # requires_compatibilities = ["EC2"]
  cpu                = "256"
  memory             = "512"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name = "${var.environment}-${var.service}-webpage"
      # image     = "nginx"
      # image     = "httpd"
      image     = "tomcat"
      essential = true
      portMappings = [
        {
          # containerPort = 80 # Tomcat default port 8080 ### 80 for httpd and nginx
          # hostPort      = 80
          containerPort = 8080 # Tomcat default port 8080 ### 80 for httpd and nginx
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