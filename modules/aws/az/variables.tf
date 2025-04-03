variable "az_id" {
  description = "The ID of the Availability Zone."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet."
  type        = string
}

variable "vpc_public_route_table_id" {
  description = "The ID of the public route table for the VPC."
  type        = string
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