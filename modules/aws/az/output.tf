output "az_private_route_table_id" {
  description = "The ID of the private route table associated with this AZ."
  value       = aws_route_table.az_private_route_table.id
}