# Content itself
module "content" {
  source = "hashicorp/dir/template"

  base_dir = "${path.root}/../content"
}

# SSL and TLS certificates for CDN
module "ssl" {
  source = "./ssl"

  # My certificates have to be created in us-east-1 as per Amazon CloudFront's
  # requirements
  providers = {
    aws = aws.us
  }
}

# CDN in front of origin
module "cdn" {
  source = "./cdn"
}

# Origin where content is stored
module "origin" {
  source = "./origin"

  content = module.content.files
}
