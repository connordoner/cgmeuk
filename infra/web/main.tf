# SSL/TLS certificate
resource "aws_acm_certificate" "default" {
  domain_name               = var.domains[0]
  subject_alternative_names = var.domains

  # Once I've moved my DNS records to Route 53, I'll change this to DNS
  validation_method = "EMAIL"
  
  # This ensures that I can validate domain ownership for subdomains that don't
  # receive email
  dynamic "validation_option" {
    for_each = var.domains
    content {
      domain_name       = validation_option.value
      validation_domain = "connorgurney.me.uk"
    }
  }

  # This creates a new SSL certificate before destroying the old one
  lifecycle {
    create_before_destroy = true
  }
}
