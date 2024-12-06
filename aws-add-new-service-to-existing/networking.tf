# Declare the availability zone data source
data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_vpc" "main" {
  id = var.vpc_id
}
output "aws_vpc" {
  value = data.aws_vpc.main.id
}
data "aws_subnet" "private" {
  filter {
    name   = "tag:Name"
    values = ["wenorg-dev-private_subnet-0", "Name:wenorg-dev-public_subnet-1"]
  }
}
resource "aws_eip" "eip" {
  domain = "vpc"
}
resource "aws_route_table" "rtb-private" {
  vpc_id = var.vpc_id
  # tags = {
  #   Name = "${var.business_division}-${var.environment}-Public-RT"
  # }
}
resource "aws_route" "rtb-private-route" {
  route_table_id         = aws_route_table.rtb-private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}