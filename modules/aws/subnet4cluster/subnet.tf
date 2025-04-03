locals {
  total_subnets = var.cluster_number * length(var.az_ids)
}

# Calculate subnet CIDRs
locals {
  # Extract the mask length from the VPC CIDR
  vpc_cidr_mask_len = element(split("/", var.base_cidr), 1)
  # Calculate the number of subnets we can have with the given mask length
  max_number_of_subnets = pow(2, var.subnet_mask_len - local.vpc_cidr_mask_len)
  # Generate the list of subnets
  subnet_cidrs = [
        for i in range(local.max_number_of_subnets) :
    cidrsubnet(var.base_cidr, var.subnet_mask_len - local.vpc_cidr_mask_len, i)
  ]

}

resource "aws_subnet" "cluster_subnet" {
  count = local.total_subnets

  vpc_id                  = var.vpc_id
  cidr_block              = local.subnet_cidrs[count.index]
  availability_zone_id    = element(var.az_ids, count.index % length(var.az_ids))
  map_public_ip_on_launch = false

  tags = merge(var.resource_common_tags, tomap({
    environment = var.environment,
    Name = "${var.name_tag_prefix}-vpc-${var.subnet_name}-cluster-${floor(count.index / length(var.az_ids))}-az-${element(var.az_ids, count.index % length(var.az_ids))}"
  }))
}

resource "aws_route_table_association" "public_subnet_association" {
  count = local.total_subnets
  subnet_id      = aws_subnet.cluster_subnet[count.index].id
  route_table_id = var.az_private_route_table_id_map[element(var.az_ids, count.index % length(var.az_ids))]
}
