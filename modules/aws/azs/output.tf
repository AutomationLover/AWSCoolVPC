output "az_private_route_table_id_map" {
  description = "The ID of the private route table associated with this AZ. az_id => az_private_route_table_id"
  value       = { 
    for index, az_id in var.az_ids : 
      az_id => module.az[index].az_private_route_table_id 
    }
}