resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.environment}-${var.service}-webpage-ecs-cluster"
  # setting {               ### Uncomment to enable container insights
  #   name  = "containerInsights"
  #   value = "enabled"
  # }
}