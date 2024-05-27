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
