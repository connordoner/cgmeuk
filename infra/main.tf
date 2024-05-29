# Network
module "network" {
  source = "./network"

  environment                   = var.environment
  domains                       = var.domains
  network_vpc_id                = null
  network_cidr_block            = var.network_cidr_block
  network_core_subnet_id_a      = null
  network_core_subnet_range_a   = var.network_core_subnet_range_a
  network_core_subnet_id_b      = null
  network_core_subnet_range_b   = var.network_core_subnet_range_b
  network_core_subnet_id_c      = null
  network_core_subnet_range_c   = var.network_core_subnet_range_c
  network_public_subnet_id_a    = null
  network_public_subnet_range_a = var.network_public_subnet_range_a
  network_public_subnet_id_b    = null
  network_public_subnet_range_b = var.network_public_subnet_range_b
  network_public_subnet_id_c    = null
  network_public_subnet_range_c = var.network_public_subnet_range_c
  ecs_cluster_id                = null
  ecs_task_execution_role_arn   = null
}

# ECS
module "ecs" {
  source = "./ecs"

  environment                   = var.environment
  domains                       = var.domains
  network_vpc_id                = module.network.vpc_id
  network_cidr_block            = var.network_cidr_block
  network_core_subnet_id_a      = module.network.core_subnet_id_a
  network_core_subnet_range_a   = var.network_core_subnet_range_a
  network_core_subnet_id_b      = module.network.core_subnet_id_b
  network_core_subnet_range_b   = var.network_core_subnet_range_b
  network_core_subnet_id_c      = module.network.core_subnet_id_c
  network_core_subnet_range_c   = var.network_core_subnet_range_c
  network_public_subnet_id_a    = module.network.public_subnet_id_a
  network_public_subnet_range_a = var.network_public_subnet_range_a
  network_public_subnet_id_b    = module.network.public_subnet_id_b
  network_public_subnet_range_b = var.network_public_subnet_range_b
  network_public_subnet_id_c    = module.network.public_subnet_id_c
  network_public_subnet_range_c = var.network_public_subnet_range_c
  ecs_cluster_id                = null
  ecs_task_execution_role_arn   = null
}

# Web
module "web" {
  source = "./web"

  environment                   = var.environment
  domains                       = var.domains
  network_vpc_id                = module.network.vpc_id
  network_cidr_block            = var.network_cidr_block
  network_core_subnet_id_a      = module.network.core_subnet_id_a
  network_core_subnet_range_a   = var.network_core_subnet_range_a
  network_core_subnet_id_b      = module.network.core_subnet_id_b
  network_core_subnet_range_b   = var.network_core_subnet_range_b
  network_core_subnet_id_c      = module.network.core_subnet_id_c
  network_core_subnet_range_c   = var.network_core_subnet_range_c
  network_public_subnet_id_a    = module.network.public_subnet_id_a
  network_public_subnet_range_a = var.network_public_subnet_range_a
  network_public_subnet_id_b    = module.network.public_subnet_id_b
  network_public_subnet_range_b = var.network_public_subnet_range_b
  network_public_subnet_id_c    = module.network.public_subnet_id_c
  network_public_subnet_range_c = var.network_public_subnet_range_c
  ecs_cluster_id                = module.ecs.cluster_id
  ecs_task_execution_role_arn   = module.ecs.task_execution_role_arn
}
