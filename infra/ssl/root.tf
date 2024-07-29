# SSL and TLS certificate for root domain
resource "aws_acm_certificate" "root" {
  domain_name               = "connorgurney.me.uk"
  subject_alternative_names = [
    "www.connorgurney.me.uk"
  ]

  validation_method = "EMAIL"

  validation_option {
    domain_name       = "www.connorgurney.me.uk"
    validation_domain = "connorgurney.me.uk"
  }

  lifecycle {
    create_before_destroy = true
  }
}

