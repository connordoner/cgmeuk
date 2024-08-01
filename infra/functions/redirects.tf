# Function itself
resource "aws_cloudfront_function" "redirects" {
  name    = "cgmeuk-redirects"
  comment = "Handles redirects to content and from non-WWW to WWW."
  publish = true

  runtime = "cloudfront-js-2.0"
  code    = file("${path.root}/../functions/redirects/function.js")

  key_value_store_associations = [aws_cloudfront_key_value_store.redirects.arn]
}

# Key-value store to store redirect rules
resource "aws_cloudfront_key_value_store" "redirects" {
  name    = "cgmeuk-redirects"
  comment = "Holds paths to redirect, their destinations and metadata about them."
}

# Outputs
output "redirects_function_arn" {
  value = aws_cloudfront_function.redirects.arn
}
