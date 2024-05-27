# VPC itself
resource "aws_vpc" "default" {
  cidr_block = var.network_cidr_block
  tags = {
    "Name" = "cgmeuk-${var.environment}"
  }
}
