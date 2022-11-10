# workers
resource "aws_security_group" "node" {
  name        = "terraform-eks-${var.env}-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name"                                         = "terraform-eks-${var.env}-node"
    "kubernetes.io/cluster/${var.env}-eks-cluster" = "owned"
  }
}

resource "aws_security_group_rule" "node-ingress" {
  description              = "Allow accept service"
  cidr_blocks              = ["0.0.0.0/0"]
  from_port                = 443
  protocol                 = "TCP"
  to_port                  = 443
  security_group_id        = aws_security_group.node.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.node.id
  source_security_group_id = aws_security_group.node.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.node.id
  source_security_group_id = var.eks_control_plane_security_group_id
  to_port                  = 65535
  type                     = "ingress"
}
