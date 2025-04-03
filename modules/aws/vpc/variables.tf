variable "vpc_nodes_cidr" {
  description = "The base CIDR block for the nodes subnets."
  type = string
}

variable "ctrl_plan_cidr" {
  description = "The base CIDR block for the control plan subnets."  
  type = string
}

variable "vpc_cidr_for_public_subnet" {
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