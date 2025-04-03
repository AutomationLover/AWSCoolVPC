
resource "aws_subnet" "public_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidr
  availability_zone_id    = var.az_id
  map_public_ip_on_launch = true
  tags = merge(var.resource_common_tags, tomap({
    environment = var.environment,
    Name = "${var.name_tag_prefix}-vpc-public-subnet-${var.az_id}"
  }))
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = merge(var.resource_common_tags, tomap({
    environment = var.environment,
    Name = "${var.name_tag_prefix}-vpc-eip-${var.az_id}"
  }))
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = merge(var.resource_common_tags, tomap({
    environment = var.environment,
    Name = "${var.name_tag_prefix}-vpc-ngw-${var.az_id}"
  }))
}

resource "aws_route_table" "az_private_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = aws_nat_gateway.nat.id
  }
  tags = merge(var.resource_common_tags, tomap({
    environment = var.environment,
    Name = "${var.name_tag_prefix}-vpc-rt-az-${var.az_id}"
  }))
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = var.vpc_public_route_table_id
}
