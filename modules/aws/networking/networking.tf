module "vpc" {
  source                     = "../../../modules/aws/vpc"
  name_tag_prefix            = var.name_tag_prefix
  resource_common_tags       = var.resource_common_tags
  environment                = var.environment
  vpc_nodes_cidr             = var.vpc_nodes_cidr
  ctrl_plan_cidr             = var.ctrl_plan_cidr
  vpc_cidr_for_public_subnet = var.vpc_cidr_for_public_subnet
}

module "azs" {
  source                              = "../../../modules/aws/azs"
  name_tag_prefix                     = var.name_tag_prefix
  resource_common_tags                = var.resource_common_tags
  environment                         = var.environment
  az_ids                              = var.az_ids
  vpc_id                              = module.vpc.vpc_id
  vpc_cidr_for_public_subnet          = var.vpc_cidr_for_public_subnet
  vpc_public_route_table_id = module.vpc.public_route_table_id
  public_subnet_mask_len              = var.public_subnet_mask_len
}

# Use the subnet module for the nodes
module "nodes_subnet" {
  source                            = "../../../modules/aws/subnet4cluster"
  name_tag_prefix                   = var.name_tag_prefix
  resource_common_tags              = var.resource_common_tags
  environment                       = var.environment
  vpc_id                            = module.vpc.vpc_id
  base_cidr                         = var.vpc_nodes_cidr
  subnet_mask_len                   = var.cluster_subnet_mask_len
  az_ids                            = var.az_ids
  cluster_number                    = var.cluster_number
  subnet_name                       = "node"
  az_private_route_table_id_map     = module.azs.az_private_route_table_id_map
}

# Use the subnet module for the control plane
module "control_plane_subnet" {
  source                        = "../../../modules/aws/subnet4cluster"
  name_tag_prefix               = var.name_tag_prefix
  resource_common_tags          = var.resource_common_tags
  environment                   = var.environment
  vpc_id                        = module.vpc.vpc_id
  base_cidr                     = var.ctrl_plan_cidr
  subnet_mask_len               = var.ctrl_plan_subnet_mask_len
  az_ids                        = var.az_ids
  cluster_number                = var.cluster_number
  subnet_name                   = "cp"
  az_private_route_table_id_map = module.azs.az_private_route_table_id_map
}  

