# Content itself
module "content" {
  source = "hashicorp/dir/template"

  base_dir = "${path.root}/../content"
}

# Origin where content is stored
module "origin" {
  source = "./origin"

  content = module.content.files
}
