resource "aws_security_group" "ecs_tasks" {
  name        = "${var.environment}-${var.service}-ecs-tasks-sg"
  description = "allow inbound access from the ALB only"
  vpc_id      = aws_vpc.main.id
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks[var.environment]
  }
  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks[var.environment]
  }
  ingress {
    from_port   = 8080 ### 80 for httpd and nginx, Tomcat default port 8080, other services may have different default ports
    to_port     = 8080 ### 80 for httpd and nginx, Tomcat default port 8080, other services may have different default ports
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks[var.environment]
    # security_groups = [aws_security_group.lb.id]
  }
  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    # cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = var.egress_cidr_blocks[var.environment]
  }
}
resource "aws_security_group" "lb" {
  description = "controls access to the Application Load Balancer (ALB)"
  name        = "${var.environment}-${var.service}-webpage-lb-sg"
  vpc_id      = aws_vpc.main.id
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks[var.environment]
  }
  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
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