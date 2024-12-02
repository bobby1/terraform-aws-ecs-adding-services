provider "aws" {
  region = var.region
}

# Data Source to retrieve existing Load Balancer and Target Group
data "aws_lb" "existing_lb" {
  #   name = "my-existing-lb"
  name = "dev-ecs-webpage-cluster-alb"
}

data "aws_lb_target_group" "existing_tg" {
  #   name = "my-existing-tg"
  name = "dev-ecs-webpage-ecs-fargate-TG"
}

# Create a new ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "my-ecs-cluster-onExisting"
}
