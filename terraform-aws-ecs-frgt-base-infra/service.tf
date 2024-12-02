resource "aws_ecs_service" "service_name" {
  name            = "${var.environment}-${var.service}-webpage-ecs-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = var.app_count[var.environment]
  launch_type     = "FARGATE"
  # launch_type = "EC2"
  network_configuration {
    security_groups = [aws_security_group.ecs_tasks2.id]
    subnets         = aws_subnet.private.*.id
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.ecs-fargate-TG.arn
    container_name   = "${var.environment}-${var.service}-webpage-webpage"
    # container_port   = 80
    container_port = 8080
  }
  depends_on = [aws_lb_listener.https_forward]
}