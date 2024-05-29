# Network
module "network" {
  source = "./network"

  environment                 = var.environment
  domains                     = var.domains
  network_vpc_id              = null
  network_cidr_block          = var.network_cidr_block
  network_core_subnet_range   = var.network_core_subnet_range
  network_public_subnet_range = var.network_public_subnet_range
}

# ECS
module "ecs" {
  source = "./ecs"

  environment                 = var.environment
  domains                     = var.domains
  network_vpc_id              = module.network.vpc_id
  network_cidr_block          = var.network_cidr_block
  network_core_subnet_range   = var.network_core_subnet_range
  network_public_subnet_range = var.network_public_subnet_range
}

# Web
module "web" {
  source = "./web"

  environment                 = var.environment
  domains                     = var.domains
  network_vpc_id              = module.network.vpc_id
  network_cidr_block          = var.network_cidr_block
  network_core_subnet_range   = var.network_core_subnet_range
  network_public_subnet_range = var.network_public_subnet_range
}
