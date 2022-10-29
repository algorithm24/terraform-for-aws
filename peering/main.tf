resource "aws_vpc_peering_connection" "peering" {
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.vpc_id
  peer_region   = "us-east-1"
}

resource "aws_vpc_peering_connection_accepter" "peering" {
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}