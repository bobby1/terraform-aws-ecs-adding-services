# # ########################################################################################################################
# # ## ECS using EC2 instance auto-scaling Only  ## EC2 instances only
# # ########################################################################################################################
# resource "aws_autoscaling_group" "ecs_autoscaling_group" {
#   name = "${var.business_division}_${var.environment}_ASG"
#   # max_size              = var.autoscaling_max_size
#   # min_size              = var.autoscaling_min_size
#   # vpc_zone_identifier   = aws_subnet.private.*.id
#   max_size            = 3
#   min_size            = 1
#   vpc_zone_identifier = aws_subnet.private.*.id
#   #   health_check_type     = "FARGATE" ### options are "EC2" or "FARGATE"
#   protect_from_scale_in = true
#   enabled_metrics = [
#     "GroupMinSize",
#     "GroupMaxSize",
#     "GroupDesiredCapacity",
#     "GroupInServiceInstances",
#     "GroupPendingInstances",
#     "GroupStandbyInstances",
#     "GroupTerminatingInstances",
#     "GroupTotalInstances"
#   ]
#   launch_template {
#     id      = aws_launch_template.ecs_launch_template.id
#     version = "$Latest"
#   }
#   instance_refresh {
#     strategy = "Rolling"
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
#   tag {
#     key                 = "Name"
#     value               = "${var.business_division}_${var.environment}_ASG"
#     propagate_at_launch = true
#   }
#   tag {
#     key                 = "service"
#     propagate_at_launch = false
#     value               = var.service
#   }
# }
