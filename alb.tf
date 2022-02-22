# APPLICATION LOAD BALANCER FILE
# terraform create application load balancer

# APPLICATION LOAD BALANCER

resource "aws_lb" "project14-alb" {
  name = "project14-alb"
  internal = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.project14-vpc-security-group.id, aws_security_group.lb.id]

  enable_deletion_protection = false

    subnet_mapping {
    subnet_id     = aws_subnet.project14-pubsubnet1.id
  }

  subnet_mapping {
    subnet_id     = aws_subnet.project14-pubsubnet2.id
  }

    subnet_mapping {
    subnet_id     = aws_subnet.project14-pubsubnet3.id
  }

  tags = {
    name = "project14-alb"
  }
}

# TARGET GROUP

resource "aws_alb_target_group" "project14_alb_target_group" {
  name        = "project14-tg"
  target_type = "instance"
  protocol    = "HTTP"
  port        = "80"
  vpc_id      = aws_vpc.project14_vpc.id

  health_check {
    healthy_threshold   = 5
    interval            = 100
    matcher             = "200,301,302"
    path                = "/"
    timeout             = 50
    unhealthy_threshold = 2
  }
}

# LISTENER ON PORT 80 WITH REDIRECT APPLICATION

resource "aws_lb_listener" "project14-alb-listener" {
  load_balancer_arn = aws_lb.project14-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.project14_alb_target_group.arn
    type             = "forward"
  }
}
