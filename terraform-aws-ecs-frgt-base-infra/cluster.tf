resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.environment}-${var.service}-webpage-ecs-cluster"
  # setting {
  #   name  = "containerInsights"
  #   value = "enabled"
  # }
}
output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs-cluster.name
}