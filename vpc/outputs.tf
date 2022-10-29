output "vpc_id" {
  value = aws_vpc.vpc.id  
}
output "subnet_ids_for_rds" {
  value = length(aws_subnet.private-subnet) > 5 ? [aws_subnet.private-subnet[3].id, aws_subnet.private-subnet[4].id, aws_subnet.private-subnet[5].id] : null
}
output "subnet_ids_elb" {
  value = length(aws_subnet.public-subnet) > 2 ? [aws_subnet.public-subnet[0].id, aws_subnet.public-subnet[1].id, aws_subnet.public-subnet[2].id] : null
}
output "subnet_ids_instance" {
  value = length(aws_subnet.private-subnet) > 2 ? [aws_subnet.private-subnet[0].id, aws_subnet.private-subnet[1].id, aws_subnet.private-subnet[2].id] : null
}
output "cidr_block_access_rds" {
  value = length(var.private_subnet_cidr_blocks) > 2 ? [var.private_subnet_cidr_blocks[0], var.private_subnet_cidr_blocks[1], var.private_subnet_cidr_blocks[2]] : null
}