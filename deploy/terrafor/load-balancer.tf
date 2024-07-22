resource "aws_lb" "sup3rS3cretMes5age" {
  name               = "sup3rS3cretMes5age-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_all.id]
  subnets            = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "sup3rS3cretMes5age" {
  name        = "sup3rS3cretMes5age-tg"
  port        = 8082
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_listener" "sup3rS3cretMes5age" {
  load_balancer_arn = aws_lb.sup3rS3cretMes5age.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sup3rS3cretMes5age.arn
  }
}
