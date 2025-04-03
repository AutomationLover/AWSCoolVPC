provider "aws" {
  region = var.region
}
module "vpc" {
  source                     = "../../modules/aws/networking"
  vpc_nodes_cidr             = var.vpc_nodes_cidr
  az_ids                     = var.az_ids
  cluster_subnet_mask_len    = var.cluster_subnet_mask_len
  cluster_number             = var.cluster_number
  ctrl_plan_cidr             = var.ctrl_plan_cidr
  ctrl_plan_subnet_mask_len  = var.ctrl_plan_subnet_mask_len
  vpc_cidr_for_public_subnet = var.vpc_cidr_for_public_subnet
  public_subnet_mask_len     = var.public_subnet_mask_len
  name_tag_prefix            = var.name_tag_prefix
  resource_common_tags       = var.resource_common_tags
  environment                = var.environment
}