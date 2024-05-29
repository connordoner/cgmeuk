# Network
module "network" {
  source = "./network"

  environment                 = var.environment
  domains                     = var.domains
  network_vpc_id              = null
  network_cidr_block          = var.network_cidr_block
  network_core_subnet_id      = null
  network_core_subnet_range   = var.network_core_subnet_range
  network_public_subnet_id    = null
  network_public_subnet_range = var.network_public_subnet_range
  ecs_cluster_id              = null
  ecs_task_execution_role_arn = null
}

# ECS
module "ecs" {
  source = "./ecs"

  environment                 = var.environment
  domains                     = var.domains
  network_vpc_id              = module.network.vpc_id
  network_cidr_block          = var.network_cidr_block
  network_core_subnet_id      = module.network.core_subnet_id
  network_core_subnet_range   = var.network_core_subnet_range
  network_public_subnet_id    = module.network.public_subnet_id
  network_public_subnet_range = var.network_public_subnet_range
  ecs_cluster_id              = null
  ecs_task_execution_role_arn = null
}

# Web
module "web" {
  source = "./web"

  environment                 = var.environment
  domains                     = var.domains
  network_vpc_id              = module.network.vpc_id
  network_cidr_block          = var.network_cidr_block
  network_core_subnet_id      = module.network.core_subnet_id
  network_core_subnet_range   = var.network_core_subnet_range
  network_public_subnet_id    = module.network.public_subnet_id
  network_public_subnet_range = var.network_public_subnet_range
  ecs_cluster_id              = module.ecs.cluster_id
  ecs_task_execution_role_arn = module.ecs.task_execution_role_arn
}
