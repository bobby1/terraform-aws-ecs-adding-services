output "igw_id" {
  value = aws_internet_gateway.igw.id
}
output "security_group_lb" {
  value = aws_security_group.lb.id
}
# output "aws_subnet_public" {
#   value = aws_subnet.public[*].id
# }
# output "subnet_public_rtb" {
#   value = aws_route_table.rtb-public.id
# }
output "aws_subnet_private" {
  value = aws_subnet.private[*].id
}
output "subnet_private_rtb" {
  value = aws_route_table.rtb-private.id
}
output "vpc-id" {
  value = aws_vpc.main.id
}
# output "ecs_cluster_lb_name" {
#   value = aws_lb.cluster_lb.name
# }
output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs-cluster.name
}
output "load_balancer_name" {
  value = aws_lb.cluster_lb.dns_name
}
