provider "aws" {
  region = var.region
}
# Data Source to retrieve existing Load Balancer and Target Group
data "aws_lb" "existing_lb" {
  name = var.load_balancer_name
}
data "aws_lb_target_group" "existing_tg" {
  # description = "Name of existing target group"
  name = var.aws_lb_target_group
}
# Create a new ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.environment}-${var.service}-Cluster"
}