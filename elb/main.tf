resource "aws_elb" "elb" {
  name = "${var.env}-elb"
  subnets = var.subnets
  security_groups = [aws_security_group.elb-securitygroup.id, ]
  listener {
    instance_port = 22
    instance_protocol = "TCP"
    lb_port = 22
    lb_protocol = "TCP"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "TCP:22"
    interval = 30
  }
  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 400
  tags = {
    Name = "${var.env}-elb"
  }
}