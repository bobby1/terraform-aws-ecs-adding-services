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
  name               = "${var.business_division}_${var.environment}_CPUTargetTrackingScaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  target_tracking_scaling_policy_configuration {
    target_value = 90.0
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}
### Policy for memory utilization tracking
resource "aws_appautoscaling_policy" "memory_scaling_policy" {
  name               = "${var.business_division}_${var.environment}_memory-scaling"
  service_namespace  = "ecs"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  policy_type        = "TargetTrackingScaling"
  target_tracking_scaling_policy_configuration {
    target_value = 90.0
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}
### Define ECS Cluster and Service autoscaling based on time
#### Scheduled action to scale out during peak hours
resource "aws_appautoscaling_scheduled_action" "scale_out_peak_hours" {
  name               = "${var.environment}-${var.service}-ecs-service-scale-up"
  service_namespace  = "ecs"
  schedule           = "cron(0 8 * * ? *)" # Every day at 08:00 UTC
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  scalable_target_action {
    min_capacity = 3
    max_capacity = 5
  }
}
#### Scheduled action to scale in during off-peak hours
resource "aws_appautoscaling_scheduled_action" "scale_in_off_peak_hours" {
  name               = "${var.environment}-${var.service}-ecs-service-scale-down"
  service_namespace  = "ecs"
  schedule           = "cron(0 20 * * ? *)" # Every day at 20:00 UTC
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  scalable_target_action {
    min_capacity = 1
    max_capacity = 3
  }
}