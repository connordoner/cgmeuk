# VPC itself
resource "aws_vpc" "default" {
  cidr_block = var.network_cidr_block

  tags = {
    Name = "cgmeuk-${var.environment}"
  }
}

# Route table
resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.default.default_route_table_id

  route {
    cidr_block = var.network_cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "cgmeuk-${var.environment}"
  }
}

# Internet gateway
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "cgmeuk-${var.environment}"
  }
}

# Subnet for network-related resources
resource "aws_subnet" "network" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.network_subnet_range

  tags = {
    Name = "cgmeuk-${var.environment}-network"
  }
}
