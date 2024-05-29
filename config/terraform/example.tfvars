# Name of environment
environment = "development"

# Domain names used to access this environment
# The first of these will be the primary domain on SSL/TLS certificates and the
# others will be Subject Alternative Names
domains = ["example.com"]

# Network configuration
network_cidr_block          = "10.0.0.0/16"
network_core_subnet_range   = "10.0.0.0/28"
network_public_subnet_range = "10.0.1.0/28"
