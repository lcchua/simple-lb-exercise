resource "aws_lb_target_group" "lcchua-tf-tg" {
  name        = "lcchua-flaskapp-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.lcchua-tf-vpc.id

  tags = {
    group = var.stack_name
    Name  = "stw-target-group"
  }
}
output "target-group" {
  description = "21 stw target group"
  value       = aws_lb_target_group.lcchua-tf-tg.id
}

resource "aws_lb" "lcchua-tf-lb" {
  name               = "lcchua-flaskapp-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lcchua-tf-sg-allow-ssh-http-https]
  subnets            = [aws_subnet.lcchua-tf-public-subnet-az1, aws_subnet.lcchua-tf-public-subnet-az2]

  tags = {
    group = var.stack_name
    Name  = "stw-load-balancer"
  }
}
output "load-balancer" {
  description = "22 stw load balancer"
  value       = aws_lb.lcchua-tf-lb.id
}

resource "aws_lb_listener" "lcchua-tf-lb_listener" {
  load_balancer_arn = aws_lb.lcchua-tf-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lcchua-tf-tg.arn
  }

  tags = {
    group = var.stack_name
    Name  = "stw-lb-listener"
  }
}
output "load-balancer-listener" {
  description = "22 stw lb listener"
  value       = aws_lb.lcchua-tf-lb.id
}

resource "aws_lb_listener_rule" "lcchua-tf-lb-listener-rule_1" {
  listener_arn = aws_lb_listener.lcchua-tf-lb_listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lcchua-tf-tg.arn
  }

  condition {
    host_header {
      values = ["lcchua-hellow.sctp-sandbox.com"]
    }
  }
  condition {
    path_pattern {
      values = ["v1"]
    }
  }

  tags = {
    group = var.stack_name
    Name  = "stw-lb-listener-rule_1"
  }
}
output "load-balancer-listener-rule_1" {
  description = "23a stw lb listener rule 1"
  value       = aws_lb_listener_rule.lcchua-tf-lb-listener-rule_1
}

resource "aws_lb_listener_rule" "lcchua-tf-lb-listener-rule_2" {
  listener_arn = aws_lb_listener.lcchua-tf-lb_listener.arn
  priority     = 2

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lcchua-tf-tg.arn
  }

  condition {
    host_header {
      values = ["lcchua-hellow.sctp-sandbox.com"]
    }
  }
  condition {
    path_pattern {
      values = ["v2"]
    }
  }

  tags = {
    group = var.stack_name
    Name  = "stw-lb-listener-rule_2"
  }
}
output "load-balancer-listener-rule_2" {
  description = "23b stw lb listener rule 12"
  value       = aws_lb_listener_rule.lcchua-tf-lb-listener-rule_2
}