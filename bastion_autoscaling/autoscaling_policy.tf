resource "aws_autoscaling_policy" "bastion-cpu-policy" {
  name = "bastion-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.bastion-autoscaling.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "1"
  cooldown = "300"
  policy_type = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "bastion-cpu-alarm" {
  alarm_name          = "bastion-cpu-alarm"
  alarm_description   = "bastion-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.bastion-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.bastion-cpu-policy.arn]
}