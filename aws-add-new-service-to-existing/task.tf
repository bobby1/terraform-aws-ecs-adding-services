resource "aws_ecs_task_definition" "task_definition2" {
  family                   = "${var.environment}-${var.service}-wbpg${var.app_port}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"] ### options are "EC2" and "FARGATE"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn = data.aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name = "${var.environment}-${var.service}-webpage${var.app_port}"
      image     = "${var.app_image}" ### option include nginx, tomcat, and httpd
      essential = true
      portMappings = [
        {
          containerPort = "${var.app_port}" # Tomcat default port 8080 ### 80 for httpd and nginx
          hostPort      = "${var.app_port}"

          protocol = "tcp"
        }
      ]
      # logConfiguration = {
      #   logDriver = "awslogs"
      #   options = {
      #     "awslogs-group"         = "wenorg-dev-ecs-cluster"
      #     "awslogs-region"        = "${var.region}"
      #     "awslogs-stream-prefix" = "add2Exst-"
      # }
      # }
    },
  ])
}