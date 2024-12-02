resource "aws_security_group" "lb2" {
  description = "controls access to the Application Load Balancer (ALB)"
  name        = "${var.environment}-${var.service}-webpage-lb-sg2"
  vpc_id      = aws_vpc.main.id
  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks[var.environment]
  }
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks[var.environment]
  }
  ingress {
    description = "tomcat port from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks[var.environment]
  }

  egress {
    description = "Cidr Blocks and ports for Egress security"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = var.egress_cidr_blocks[var.environment]
  }
}

output "aws_security_group_lb2" {
  value = aws_security_group.lb2.id
}

resource "aws_security_group" "ecs_tasks2" {
  name        = "${var.environment}-${var.service}-webpage-ecs-tasks-sg2"
  description = "allow inbound access from the ALB only"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.lb2.id]
  }
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks[var.environment]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}