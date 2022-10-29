resource "aws_security_group" "allow-mariadb" {
  vpc_id = var.vpc_id
  name = "${var.env}-allow-mariadb"
  ingress {
    description = "Access to DB inside Private Subnet"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = var.cidr_block_access
    security_groups = [var.bastion_sg]
  }
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