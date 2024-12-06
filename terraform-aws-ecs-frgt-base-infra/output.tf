output "igw_id" {
  value = aws_internet_gateway.igw.id
}
output "security_groups" {
  value = aws_security_group.lb.id
  # value       = "[${aws_security_group.lb.id}]"
  description = "Security group ID for the load balancer"
}
# output "aws_subnet_public" {
#   value = aws_subnet.public[*].id
# }
# output "subnet_public_rtb" {
#   value = aws_route_table.rtb-public.id
# }
# output "aws_subnet_private" {
output "subnets" {
  value = aws_subnet.private[*].id
}
# output "subnet_private_rtb" {
output "route_table_id" {
  value       = aws_route_table.rtb-private.id
  description = "value of the route table id"
}
output "vpc_id" {
  value = aws_vpc.main.id
}
# output "ecs_cluster_lb_name" {
#   value = aws_lb.cluster_lb.name
# }
output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs-cluster.name
}
output "load_balancer_DNS_name" {
  value = aws_lb.cluster_lb.dns_name
}
output "load_balancer_name" {
  value = aws_lb.cluster_lb.name
}

