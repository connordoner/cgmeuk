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

# Load balancer
resource "aws_lb" "default" {
  name               = "cgmeuk-${var.environment}"
  load_balancer_type = "application"
  internal           = false

  # Networking
  subnets = [
    var.network_public_subnet_id_a,
    var.network_public_subnet_id_b,
    var.network_public_subnet_id_c
  ]

  # Security
  security_groups    = [aws_security_group.lb.id]
}

# Target group for load balancer
resource "aws_lb_target_group" "default" {
  name        = "cgmeuk-${var.environment}"
  vpc_id      = var.network_vpc_id
  target_type = "ip"
  protocol    = "HTTP"
  port        = 80
}

# Listener for load balancer
resource "aws_lb_listener" "default" {
  load_balancer_arn = aws_lb.default.arn
  protocol          = "HTTPS"
  port              = "443"
  certificate_arn   = aws_acm_certificate.default.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }
}

# Security group for load balancer
resource "aws_security_group" "lb" {
  vpc_id     = var.network_vpc_id
  name       = "cgmeuk-${var.environment}-lb"

  # Allow all outbound traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow inbound traffic on HTTP
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Allow inbound traffic on HTTPS
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

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

  # Allow inbound traffic on HTTP from load balancer
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [aws_security_group.lb.id]
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
  depends_on      = [aws_lb_listener.default]
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.web.arn

  # Whether to deploy via AWS Fargate or EC2
  launch_type = "FARGATE"

  # How many containers to launch
  # Three is a minimum if I want to run across all three of the availability
  # zones in my region
  desired_count = 3

  # Networking
  network_configuration {
    subnets = [
      var.network_public_subnet_id_a,
      var.network_public_subnet_id_b,
      var.network_public_subnet_id_c
    ]
    security_groups = [aws_security_group.web.id]

    # TODO: After setting up a load balancer, I'll remove this
    assign_public_ip = true
  }

  # Target group registration
  load_balancer {
    target_group_arn = aws_lb_target_group.default.arn
    container_name   = "cgmeuk-${var.environment}-web"
    container_port   = 80
  }
}
