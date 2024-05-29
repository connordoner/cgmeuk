# ECS Cluster itself
resource "aws_ecs_cluster" "default" {
  name = "cgmeuk-${var.environment}"
}


