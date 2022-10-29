resource "aws_launch_template" "bastion-launchtemplate" {
  name_prefix = "bastion-launchtemplate"
  image_id = "ami-08c40ec9ead489470"
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.bastion-allow-ssh.id,]
  user_data = base64encode(data.template_file.user-data.rendered)
}
resource "aws_autoscaling_group" "bastion-autoscaling" {
  name = "bastion-autoscaling"
  vpc_zone_identifier = var.vpc_zone_identifier
  launch_template {
    id      = aws_launch_template.bastion-launchtemplate.id
    version = "$Latest"
  }
  min_size = 1
  max_size = 3
  health_check_grace_period = 300
  health_check_type = "ELB"
  force_delete = true
  load_balancers = var.load_balancers
  tag {
      key = "Name"
      value = "ec2 instance"
      propagate_at_launch = true
  }
}