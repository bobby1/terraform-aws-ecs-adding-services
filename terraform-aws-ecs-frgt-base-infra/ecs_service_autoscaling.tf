## Define ECS Cluster and Service autoscaling
resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 3
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.ecs-cluster.name}/${aws_ecs_service.service_name.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}
### Policy for CPU utilization tracking
resource "aws_appautoscaling_policy" "ecs_cpu_policy" {
  name               = "${var.business_division}_${var.environment}_CPU_scaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  target_tracking_scaling_policy_configuration {
    target_value = 85.0
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}
### Policy for memory utilization tracking
resource "aws_appautoscaling_policy" "memory_scaling_policy" {
  name               = "${var.business_division}_${var.environment}_memory_scaling"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  policy_type        = "TargetTrackingScaling"
  target_tracking_scaling_policy_configuration {
    target_value = 85.0
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}
### Scheduled action to start and stop the service on dev and staging environments
resource "aws_appautoscaling_scheduled_action" "start_service" {
  count              = var.environment == "prd" ? 0 : 1
  name               = "${var.environment}-${var.service}-srv-${local.current_timestamp}-start"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = "ecs:service:DesiredCount"
  schedule           = "cron(00 06 ? * MON-FRI *)"
  service_namespace  = "ecs"
  timezone           = "America/Los_Angeles"
  scalable_target_action {
    min_capacity = 1
    max_capacity = 2
  }
}
resource "aws_appautoscaling_scheduled_action" "stop_service" {
  count              = var.environment == "prd" ? 0 : 1
  name               = "${var.environment}-${var.service}-srv-${local.current_timestamp}-stop"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = "ecs:service:DesiredCount"
  schedule           = "cron(00 19 ? * MON-FRI *)"
  service_namespace  = "ecs"
  timezone           = "America/Los_Angeles"
  scalable_target_action {
    min_capacity = 0
    max_capacity = 0
  }
}