# ID of S3 bucket used as origin
variable "origin_id" {
  description = "ID of the S3 bucket used as the origin."
}

# Regional domain name of S3 bucket used as origin
variable "origin_domain_name" {
  description = "Regional domain name for the S3 bucket used as the origin."
}

# ARN of SSL and TLS certificate to serve content with
variable "certificate_arn" {
  description = "ARN of the SSL and TLS certificate to serve content with."
}
