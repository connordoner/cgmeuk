# Name of environment
environment = "development"

# Domain names used to access this environment
# The first of these will be the primary domain on SSL/TLS certificates and the
# others will be Subject Alternative Names
domains = ["example.com"]

# Network configuration
network_cidr_block             = "10.0.0.0/16"
network_core_subnet_range_a    = "10.0.0.0/28"
network_core_subnet_range_b    = "10.0.1.0/28"
network_core_subnet_range_c    = "10.0.2.0/28"
network_public_subnet_range_a  = "10.0.10.0/28"
network_public_subnet_range_b  = "10.0.11.0/28"
network_public_subnet_range_c  = "10.0.12.0/28"
network_private_subnet_range_a = "10.0.20.0/28"
network_private_subnet_range_b = "10.0.21.0/28"
network_private_subnet_range_c = "10.0.22.0/28"
