# Bucket itself
resource "aws_s3_bucket" "content" {
  bucket = "cgmeuk-content"
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

