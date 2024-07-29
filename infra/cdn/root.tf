# CDN distribution
resource "aws_cloudfront_distribution" "root" {
  enabled = true
  aliases = [
    "connorgurney.me.uk",
    "www.connorgurney.me.uk"
  ]

  origin {
    domain_name = var.origin_domain_name
    origin_id   = var.origin_id
    
    origin_access_control_id = aws_cloudfront_origin_access_control.root.id
  }

  default_root_object = "index.html"

  viewer_certificate {
    acm_certificate_arn = var.certificate_arn
    ssl_support_method  = "sni-only"
  }

  default_cache_behavior {
    target_origin_id = var.origin_id

    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

# Origin access control
resource "aws_cloudfront_origin_access_control" "root" {
  name = "cgmeuk"

  origin_access_control_origin_type = "s3"
  
  signing_behavior = "always"
  signing_protocol = "sigv4"
}

# Outputs
output "distribution_arn" {
  value = aws_cloudfront_distribution.root.arn
}
