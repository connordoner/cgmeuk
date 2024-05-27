# Network
module "network" {
  source = "./network"
  environment = var.environment
  network_cidr_block = var.network_cidr_block
  network_subnet_range = var.network_subnet_range
}
