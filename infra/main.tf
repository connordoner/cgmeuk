# Network
module "network" {
  source = "./network"

  environment          = var.environment
  domains              = var.domains
  network_cidr_block   = var.network_cidr_block
  network_subnet_range = var.network_subnet_range
}

# ECS
resource "aws_ecs_cluster" "default" {
  name = "cgmeuk-${var.environment}"
}

# Web
module "web" {
  source = "./web"

  environment          = var.environment
  domains              = var.domains
  network_cidr_block   = var.network_cidr_block
  network_subnet_range = var.network_subnet_range
}

