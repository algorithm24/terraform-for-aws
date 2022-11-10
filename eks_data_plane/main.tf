data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.eks_control_plane_version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon
}
locals {
  node-userdata = <<USERDATA
#!/bin/bash
mkdir /mnt/pv-{alert, server}
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${var.eks_control_plane_endpoint}' --b64-cluster-ca '${var.eks_control_plane_certificate_authority}' '${var.env}-eks-control-plane'
USERDATA

}

resource "aws_launch_template" "node-launch-template" {
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.node.id]
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.node.name
  }
  image_id                    = data.aws_ami.eks-worker.id
  instance_type               = var.instance_type
  name_prefix                 = "terraform-${var.env}-eks"
  user_data                   = base64encode(local.node-userdata)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "node-autoscaling-group" {
  desired_capacity     = var.desired_capacity
  launch_template {
    id      = aws_launch_template.node-launch-template.id
    version = "$Latest"
  }
  max_size             = 9
  min_size             = 1
  name                 = "terraform-${var.env}-eks"
  vpc_zone_identifier  = var.vpc_zone_identifier
  tag {
    key                 = "Name"
    value               = "terraform-${var.env}-eks"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.env}-eks-control-plane"
    value               = "owned"
    propagate_at_launch = true
  }
}
