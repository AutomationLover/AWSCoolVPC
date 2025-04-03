output "vpc_id" {
  description = "vpc_id"
  value       = aws_vpc.vpc.id
}
output "public_route_table_id" {
  description = "vpc_id"
  value       = aws_route_table.vpc_public_route_table.id
}
