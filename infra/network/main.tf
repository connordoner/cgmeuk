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

# Subnet for network-related resources in availability zone A
resource "aws_subnet" "core_a" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.network_core_subnet_range_a
  availability_zone = "eu-west-2a"

  tags = {
    Name = "cgmeuk-${var.environment}-a-core"
  }
}

output "core_subnet_id_a" {
  value = aws_subnet.core_a.id
}

# Subnet for network-related resources in availability zone B
resource "aws_subnet" "core_b" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.network_core_subnet_range_b
  availability_zone = "eu-west-2b"

  tags = {
    Name = "cgmeuk-${var.environment}-b-core"
  }
}

output "core_subnet_id_b" {
  value = aws_subnet.core_b.id
}

# Subnet for network-related resources in availability zone C
resource "aws_subnet" "core_c" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.network_core_subnet_range_c
  availability_zone = "eu-west-2c"

  tags = {
    Name = "cgmeuk-${var.environment}-c-core"
  }
}

output "core_subnet_id_c" {
  value = aws_subnet.core_c.id
}

# Subnet for public-facing resources in availability zone A
resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.network_public_subnet_range_a
  availability_zone = "eu-west-2a"

  tags = {
    Name = "cgmeuk-${var.environment}-a-public"
  }
}

output "public_subnet_id_a" {
  value = aws_subnet.public_a.id
}

# Subnet for public-facing resources in availability zone B
resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.network_public_subnet_range_b
  availability_zone = "eu-west-2b"

  tags = {
    Name = "cgmeuk-${var.environment}-b-public"
  }
}

output "public_subnet_id_b" {
  value = aws_subnet.public_b.id
}

# Subnet for public-facing resources in availability zone C
resource "aws_subnet" "public_c" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.network_public_subnet_range_c
  availability_zone = "eu-west-2c"

  tags = {
    Name = "cgmeuk-${var.environment}-c-public"
  }
}

output "public_subnet_id_c" {
  value = aws_subnet.public_c.id
}
