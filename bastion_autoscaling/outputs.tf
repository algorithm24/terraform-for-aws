output "bastion-sg" {
  value = aws_security_group.bastion-allow-ssh.id
}