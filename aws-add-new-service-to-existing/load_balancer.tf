data "aws_lb" "cluster_lb" {
  name = var.load_balancer_name
}
resource "aws_lb_listener" "https_forward" {
  load_balancer_arn = data.aws_lb.cluster_lb.arn
  port              = var.app_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-fargate-TG.arn
  }
}
resource "aws_lb_target_group" "ecs-fargate-TG" {
  name        = "${var.environment}-${var.service}-new-frgt-TG"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.main.id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "90"
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = "20"
    path                = "/"
    unhealthy_threshold = "2"
  }
}
