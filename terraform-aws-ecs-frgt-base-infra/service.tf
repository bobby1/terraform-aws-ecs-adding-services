resource "aws_ecs_service" "service_name" {
  name            = "${var.environment}-${var.service}-ecs-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE" ### Options are "EC2" or "FARGATE".  Default is EC2
  network_configuration {
    security_groups = [aws_security_group.ecs_tasks.id]
    subnets         = aws_subnet.private.*.id
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.ecs-fargate-TG.arn
    container_name   = "${var.environment}-${var.service}-tsk-${var.app_port}"
    container_port   = var.app_port
  }
  depends_on = [aws_lb_listener.https_forward]
}