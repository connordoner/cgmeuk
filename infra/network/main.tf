# VPC itself
resource "aws_vpc" "default" {
  cidr_block = var.network_cidr_block

  tags = {
    Name = "cgmeuk-${var.environment}"
  }
}

output "vpc_id" {
  value = aws_vpc.default.id
}

# Route table
resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.default.default_route_table_id

  # Route for traffic between subnets
  route {
    cidr_block = var.network_cidr_block
    gateway_id = "local"
  }

  # Route for bidirectional internet traffic from and to public-facing resources
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
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
resource "aws_subnet" "core" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.network_core_subnet_range

  tags = {
    Name = "cgmeuk-${var.environment}-core"
  }
}

output "core_subnet_id" {
  value = aws_subnet.core.id
}

# Subnet for public-facing resources
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.default.id
  cidr_block = var.network_public_subnet_range

  tags = {
    Name = "cgmeuk-${var.environment}-public"
  }
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}
