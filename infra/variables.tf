# Name of environment to deploy
variable "environment" {
  description = "Name of environment to deploy to."
  type        = string
}

# CIDR block to use when addressing Terraform-generated resources
variable "network_cidr_block" {
  description = "CIDR block to use when addressing Terraform-generated resources."
  type        = string
}

# CIDR range to use for subnet housing network-related resources
variable "network_subnet_range" {
  description = "CIDR range to use for subnet housing network-related resources"
  type        = string
}
