# Bucket itself
resource "aws_s3_bucket" "content" {
  bucket = "connorgurney-cgmeuk-prod-content"
}

# Content within bucket
resource "aws_s3_object" "content" {
  for_each = var.content

  # Location
  bucket = aws_s3_bucket.content.bucket
  key    = each.key
  
  # Metadata
  content_type = each.value.content_type
  etag         = each.value.digests.md5

  # Content itself
  source = each.value.source_path
}

# Access policy for bucket
resource "aws_s3_bucket_policy" "content" {
  bucket = aws_s3_bucket.content.id
  policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.content.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = var.cdn_arn
          }
        }
      }
    ]
  })
}

# Outputs
output "bucket_id" {
  value = aws_s3_bucket.content.id
}

output "bucket_domain_name" {
  value = aws_s3_bucket.content.bucket_regional_domain_name
}
