resource "aws_ecs_task_definition" "sup3rS3cretMes5age" {
  family                   = "sup3rS3cretMes5age"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "vault"
      image     = "hashicorp/vault:latest"
      essential = true
      environment = [
        {
          name  = "VAULT_DEV_ROOT_TOKEN_ID"
          value = "supersecret"
        }
      ]
      portMappings = [{
        containerPort = 8200
        hostPort      = 8200
      }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/sup3rS3cretMes5age"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "vault"
        }
      }
    },
    {
      name      = "supersecret"
      image     = "algolia/supersecretmessage:latest"
      essential = true
      environment = [
        {
          name  = "VAULT_ADDR"
          value = "http://vault:8200"
        },
        {
          name  = "VAULT_TOKEN"
          value = "supersecret"
        },
        {
          name  = "SUPERSECRETMESSAGE_HTTP_BINDING_ADDRESS"
          value = ":8082"
        }
      ]
      portMappings = [{
        containerPort = 8082
        hostPort      = 8082
      }]
      dependsOn = [{
        containerName = "vault"
        condition     = "START"
      }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/sup3rS3cretMes5age"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "supersecret"
        }
      }
    }
  ])
}
