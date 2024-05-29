# Security group for web servers
resource "aws_security_group" "web" {
  vpc_id = var.network_vpc_id
  name   = "cgmeuk-${var.environment}-web"

  # Allow all outbound traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow inbound traffic on HTTP
  # TODO: Replace this with HTTPS when a load balancer is in place and can deal
  # with SSL/TLS
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# ECS task definition for web servers
resource "aws_ecs_task_definition" "web" {
  # Name
  family = "cgmeuk-${var.environment}-web"

  # Container environment
  requires_compatibilities = ["FARGATE"]

  # Hardware 
  cpu    = 256
  memory = 512

  # Networking
  network_mode = "awsvpc"

  # Permissions
  execution_role_arn = var.ecs_task_execution_role_arn

  # Containers within task definition
  container_definitions = jsonencode([
    {
      # Name of container
      name = "cgmeuk-${var.environment}-web"

      # Whether container is essential
      essential = true

      # URL to container from Docker Hub
      image = "docker.io/connordoner/cgmeuk-web:latest"

      # Docker credentials
      repositoryCredentials = {
        credentialsParameter = "arn:aws:secretsmanager:eu-west-2:788754665538:secret:cgmeuk/global/docker-ftPfUF"
      }

      # Hardware
      cpu    = 256
      memory = 512

      # Networking
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

# ECS service for web servers
resource "aws_ecs_service" "web" {
  name            = "cgmeuk-${var.environment}-web"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.web.arn

  # Whether to deploy via AWS Fargate or EC2
  launch_type = "FARGATE"

  # How many containers to launch
  # TODO: When I have an idea of how much traffic I'm likely to get and end up
  # finally deploying to multiple availability zones, I'll need to increase this
  desired_count = 1

  # Networking
  network_configuration {
    subnets         = [var.network_public_subnet_id]
    security_groups = [aws_security_group.web.id]

    # TODO: After setting up a load balancer, I'll remove this
    assign_public_ip = true
  }
}

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
