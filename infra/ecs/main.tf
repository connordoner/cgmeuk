# ECS Cluster itself
resource "aws_ecs_cluster" "default" {
  name = "cgmeuk-${var.environment}"
}

output "cluster_id" {
  value = aws_ecs_cluster.default.id
}

# IAM role for ECS task execution
resource "aws_iam_role" "ecs_task_execution" {
  name = "cgmeuk-${var.environment}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

output "task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}

# IAM policy for accessing Secrets Manager
resource "aws_iam_policy" "ecs_task_execution" {
  name        = "cgmeuk-${var.environment}-ecs-task-execution-policy"
  description = "Allows ECS tasks to access credentials for Docker Hub from Secrets Manager."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = "arn:aws:secretsmanager:eu-west-2:788754665538:secret:cgmeuk/global/docker-ftPfUF"
      },
      {
        Effect = "Allow",
        Action = [
          "kms:Decrypt"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attachment between role and policy
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.ecs_task_execution.arn
}

