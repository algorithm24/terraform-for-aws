resource "aws_security_group" "eks-control-plane" {
  name        = "terraform-eks-${var.env}-eks-control-plane"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-${var.env}-eks"
  }
}

resource "aws_security_group_rule" "eks-control-plane-ingress-eks-data-plane-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-control-plane.id
  source_security_group_id = var.eks_data_plane_security_group_id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks-control-plane-ingress-workstation-https" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks-control-plane.id
  to_port           = 443
  type              = "ingress"
}