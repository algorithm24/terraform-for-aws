resource "aws_security_group" "bastion-allow-ssh" {
  vpc_id      = var.vpc_id
  name        = "bastion-allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress {
    description = "Bastion host access to internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Access to bastion host through SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bastion-allow-ssh"
  }
}