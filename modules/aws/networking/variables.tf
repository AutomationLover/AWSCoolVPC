variable "vpc_nodes_cidr" {
  description = "The base CIDR block for the nodes subnets."
  type = string
}

variable "az_ids" {
  description = "The list of availability zone id."
  type = list(string)
}

variable "cluster_subnet_mask_len" {
  description = "The subnet mask length for cluster subnet."    
  type = number
}

variable "cluster_number" {
  description = "Number of cluster to create per region."
  type = number
}

variable "ctrl_plan_cidr" {
  description = "The base CIDR block for the control plan subnets."  
  type = string
}

variable "ctrl_plan_subnet_mask_len" {
  description = "The subnet mask length for control plan subnet."    
  type = number
}

variable "vpc_cidr_for_public_subnet" {
  description = "The subnet mask length for public subnet."    
  type = string
}

variable "public_subnet_mask_len" {
  description = "The subnet mask length for public subnet."    
  type = string
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