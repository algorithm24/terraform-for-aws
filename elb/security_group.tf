resource "aws_security_group" "elb-securitygroup" {
  vpc_id = var.vpc_id
  name = "elb"
  description = "Security group to communicate through ELB"
  egress {
    description = "Access to External through ELB"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Access to Internal through ELB"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "elb"
  }
}