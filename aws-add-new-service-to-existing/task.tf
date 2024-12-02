resource "aws_ecs_task_definition" "task_definition2" {
  family                   = "${var.environment}-${var.service}-webpage2"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  # requires_compatibilities = ["EC2"]
  # requires_compatibilities = ["FARGATE", "EC2"]  
  cpu                = "256"
  memory             = "512"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name = "${var.environment}-${var.service}-webpage2"
      # image = "nginx"
      image = "httpd"
      # image     = "tomcat"
      essential = true
      portMappings = [
        {
          containerPort = 80 # Tomcat default port 8080 ### 80 for httpd and nginx
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "wenorg-dev-ecs-cluster"
          "awslogs-region"        = "${var.region}"
          "awslogs-stream-prefix" = "add2Exst-"
        }
      }
    }
  ])
}