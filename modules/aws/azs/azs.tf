locals {
  # Extract the mask length from the VPC CIDR
  vpc_cidr_mask_len = element(split("/", var.vpc_cidr_for_public_subnet), 1)
  # Calculate the number of subnets we can have with the given mask length
  max_number_of_subnets = pow(2, var.public_subnet_mask_len - local.vpc_cidr_mask_len)
  # Generate the list of subnets
  subnet_cidrs = [
        for i in range(local.max_number_of_subnets) :
    cidrsubnet(var.vpc_cidr_for_public_subnet, var.public_subnet_mask_len - local.vpc_cidr_mask_len, i)
  ]

}

module "az" {
  source                              = "../../../modules/aws/az"
  count                               = length(var.az_ids)

  name_tag_prefix                     = var.name_tag_prefix
  resource_common_tags                = var.resource_common_tags
  environment                         = var.environment
  vpc_id                              = var.vpc_id
  az_id                               = var.az_ids[count.index]

  public_subnet_cidr                  = local.subnet_cidrs[count.index]
  vpc_public_route_table_id = var.vpc_public_route_table_id
}
