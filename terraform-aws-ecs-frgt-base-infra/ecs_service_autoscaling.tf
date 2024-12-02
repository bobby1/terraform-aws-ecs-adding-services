# ########################################################################################################################
# ## Define Target Tracking on ECS Cluster Task level
# ########################################################################################################################
# resource "aws_appautoscaling_target" "ecs_target" {
#   #   max_capacity       = var.ecs_task_max_count
#   #   min_capacity       = var.ecs_task_min_count
#   max_capacity       = 3
#   min_capacity       = 1
#   resource_id        = "service/${aws_ecs_cluster.ecs-cluster.name}/${aws_ecs_service.service_name.name}"
#   scalable_dimension = "ecs:service:DesiredCount"
#   service_namespace  = "ecs"
# }

# ########################################################################################################################
# ## Policy for CPU tracking
# ########################################################################################################################
# resource "aws_appautoscaling_policy" "ecs_cpu_policy" {
#   name               = "${var.business_division}_${var.environment}_CPUTargetTrackingScaling"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.ecs_target.resource_id
#   scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

#   target_tracking_scaling_policy_configuration {
#     # target_value = var.cpu_target_tracking_desired_value
#     target_value = "256"

#     predefined_metric_specification {
#       predefined_metric_type = "ECSServiceAverageCPUUtilization"
#     }
#   }
# }

# ########################################################################################################################
# ## Policy for memory tracking
# ########################################################################################################################
# resource "aws_appautoscaling_policy" "ecs_memory_policy" {
#   name               = "${var.business_division}_${var.environment}_MemoryTargetTrackingScaling"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.ecs_target.resource_id
#   scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
#   target_tracking_scaling_policy_configuration {
#     # target_value = var.memory_target_tracking_desired_value
#     target_value = 1
#     predefined_metric_specification {
#       predefined_metric_type = "ECSServiceAverageMemoryUtilization"
#     }
#   }
# }
