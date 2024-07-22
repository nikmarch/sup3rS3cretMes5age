resource "aws_ecs_service" "sup3rS3cretMes5age" {
  name            = "sup3rS3cretMes5age-service"
  cluster         = aws_ecs_cluster.sup3rS3cretMes5age.id
  task_definition = aws_ecs_task_definition.sup3rS3cretMes5age.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
    security_groups = [aws_security_group.allow_all.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.sup3rS3cretMes5age.arn
    container_name   = "supersecret"
    container_port   = 8082
  }
}
