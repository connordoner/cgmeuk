# Content itself
module "content" {
  source = "hashicorp/dir/template"

  base_dir = "${path.root}/../content"
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
