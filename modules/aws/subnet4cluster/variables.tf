variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "base_cidr" {
  description = "The base CIDR block for the subnets."
  type        = string
}

variable "subnet_mask_len" {
  description = "The subnet mask length."
  type        = number
}

variable "az_ids" {
  description = "The list of availability zone id."
  type        = list(string)
}

variable "cluster_number" {
  description = "Number of cluster to create per region."
  type = number
}  

variable "subnet_name" {
  description = "The Function Name for the subnets. e.g. nodes or ctrl-plan"
  type        = string
}

variable "az_private_route_table_id_map" {
  description = "The ID of the private route table associated with this AZ. az_id => az_private_route_table_id"
  type        = map(string)  
}

variable "environment" {
  description = "deployment environment, e.g. dev, stg, or prod"
  type        = string
}

variable "resource_common_tags" {
  description = "The common tags for resources ."
  type = map(string)
}

variable "name_tag_prefix" {
  description = "The prefix on the resource name tag."
  type = string
}