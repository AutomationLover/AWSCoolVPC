resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_nodes_cidr
  enable_dns_hostnames  = true
  tags = merge(var.resource_common_tags, tomap({
    environment = var.environment,
    Name = "${var.name_tag_prefix}-vpc"
  }))
}
resource "aws_vpc_ipv4_cidr_block_association" "ctrl_plan_cidr" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.ctrl_plan_cidr
}
resource "aws_vpc_ipv4_cidr_block_association" "public_cidr" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.vpc_cidr_for_public_subnet
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id     = aws_vpc.vpc.id
  tags = merge(var.resource_common_tags, tomap({
    environment = var.environment,
    Name = "${var.name_tag_prefix}-vpc-igw"
  }))
}


resource "aws_route_table" "vpc_public_route_table" {
  vpc_id                    = aws_vpc.vpc.id
  tags = merge(var.resource_common_tags, tomap({
    environment = var.environment,
    Name = "${var.name_tag_prefix}-vpc-rt-public"
  }))
}

resource "aws_route" "vpc-public-route-table-default-route" {
  route_table_id          = aws_route_table.vpc_public_route_table.id
  gateway_id              = aws_internet_gateway.vpc_igw.id
  destination_cidr_block  = "0.0.0.0/0"
}