resource "aws_ecs_service" "main" {
  name            = "my-ecs-service"
  cluster         = aws_ecs_cluster.main.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.task_definition2.arn
  desired_count   = 1
  network_configuration {
    # security_groups = [aws_security_group.ecs_tasks2.id]
    # subnets         = aws_subnet.private.*.id
    security_groups = var.security_groups ### security group for the ALB
    subnets         = var.subnets         ### security group for the ALB
  }
  load_balancer {
    target_group_arn = data.aws_lb_target_group.existing_tg.arn
    container_name   = "${var.environment}-${var.service}-webpage2"
    container_port   = 80
  }
  depends_on = [aws_lb_listener.https_forward]
}