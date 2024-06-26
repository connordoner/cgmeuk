# Name of environment to deploy
variable "environment" {
  description = "Name of environment to deploy to."
  type        = string
}

# Domain names used to serve this environment
variable "domains" {
  description = "Domain names used to serve this environment."
  type        = list(string)
}

# ID of VPC generated by Terraform from `network` module
variable "network_vpc_id" {
  description = "ID of VPC generated by Terraform from `network` module."
  type        = string
  default     = null
}

# CIDR block to use when addressing Terraform-generated resources
variable "network_cidr_block" {
  description = "CIDR block to use when addressing Terraform-generated resources."
  type        = string
}

# ID of subnet housing network-related resources in availability zone A generated by Terraform from `network` module
variable "network_core_subnet_id_a" {
  description = "ID of subnet housing network-related resources in availability zone A generated by Terraform from `network` module"
  type        = string
  default     = null
}

# CIDR range to use for subnet housing network-related resources in availability
# zone A
variable "network_core_subnet_range_a" {
  description = "CIDR range to use for subnet housing network-related resources in availability zone A"
  type        = string
}

# ID of subnet housing network-related resources in availability zone B
# generated by Terraform from `network` module
variable "network_core_subnet_id_b" {
  description = "ID of subnet housing network-related resources in availability zone B generated by Terraform from `network` module"
  type        = string
  default     = null
}

# CIDR range to use for subnet housing network-related resources in availability
# zone B
variable "network_core_subnet_range_b" {
  description = "CIDR range to use for subnet housing network-related resources in availability zone B"
  type        = string
}

# ID of subnet housing network-related resources in availability zone C
# generated by Terraform from `network` module
variable "network_core_subnet_id_c" {
  description = "ID of subnet housing network-related resources in availability zone C generated by Terraform from `network` module"
  type        = string
  default     = null
}

# CIDR range to use for subnet housing network-related resources in availability
# zone C
variable "network_core_subnet_range_c" {
  description = "CIDR range to use for subnet housing network-related resources in availability zone C"
  type        = string
}

# ID of subnet housing public-facing resources in availability zone A generated
# by Terraform from `network` module
variable "network_public_subnet_id_a" {
  description = "ID of subnet housing public-facing resources in availability zone A generated by Terraform from `network` module"
  type        = string
  default     = null
}

# CIDR range to use for subnet housing public-facing resources in availability
# zone A
variable "network_public_subnet_range_a" {
  description = "CIDR range to use for subnet housing public-facing resources in availability zone A"
  type        = string
}

# ID of subnet housing public-facing resources in availability zone B generated
# by Terraform from `network` module
variable "network_public_subnet_id_b" {
  description = "ID of subnet housing public-facing resources in availability zone B generated by Terraform from `network` module"
  type        = string
  default     = null
}

# CIDR range to use for subnet housing public-facing resources in availability
# zone B
variable "network_public_subnet_range_b" {
  description = "CIDR range to use for subnet housing public-facing resources in availability zone B"
  type        = string
}

# ID of subnet housing public-facing resources in availability zone C generated
# by Terraform from `network` module
variable "network_public_subnet_id_c" {
  description = "ID of subnet housing public-facing resources in availability zone C generated by Terraform from `network` module"
  type        = string
  default     = null
}

# CIDR range to use for subnet housing public-facing resources in availability
# zone C
variable "network_public_subnet_range_c" {
  description = "CIDR range to use for subnet housing public-facing resources in availability zone C"
  type        = string
}

# ID of ECS cluster generated by Terraform in `ecs` module
variable "ecs_cluster_id" {
  description = "ID of ECS cluster generated by Terraform in `ecs` module."
  type        = string
  default     = null
}

# ARN of the task execution role for ECS to use when running tasks
variable "ecs_task_execution_role_arn" {
  description = "ARN of the task execution role for ECS to use when running tasks."
  type        = string
  default     = null
}
