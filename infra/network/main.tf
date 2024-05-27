# VPC itself
resource "aws_vpc" "default" {
  cidr_block = var.network_cidr_block
  tags = {
    # Name of network
    # This is a special case because AWS requires it to begin with an uppercase
    # character (as if I don't have enough problems on my hands already!)
    "Name" = "cgmeuk-${var.environment}"

    # Actual tags
    "connorgurney:name"        = "cgmeuk-${var.environment}"
    "connorgurney:workload"    = "cgmeuk"
    "connorgurney:environment" = var.environment
  }
}
