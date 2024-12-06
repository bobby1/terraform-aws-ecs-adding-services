resource "aws_ecs_service" "main" {
  name            = "${var.environment}-${var.service}-service"
  cluster         = aws_ecs_cluster.main.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.task_definition2.arn
  desired_count   = 1
  network_configuration {
    security_groups = var.security_groups ### security group for the ALB
    subnets         = var.subnets         ### security group for the ALB
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.ecs-fargate-TG.arn
    container_name   = "${var.environment}-${var.service}-webpage${var.app_port}"
    container_port   = var.app_port
  }
  depends_on = [aws_lb_listener.https_forward]
}