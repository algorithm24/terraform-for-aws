resource "aws_security_group" "allow-mariadb" {
  vpc_id = var.vpc_id
  name = "${var.env}-allow-mariadb"
  description = "Security group to access DB from private subnets"
  egress {
    description = "DB instance acess to the Internet"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self = true
  }
  tags = {
    Name = "${var.env}-allow-mariadb"
  }
}
resource "aws_security_group_rule" "node-ingress" {
  description              = "Access to DB inside Private Subnets"
  cidr_blocks              = var.cidr_block_access
  from_port                = 3306
  protocol                 = "TCP"
  to_port                  = 3306
  security_group_id        = aws_security_group.allow-mariadb.id
  type                     = "ingress"
}