resource "aws_sns_topic" "topic" {
    name = join("-", [var.name, "notification-topic"])

    tags = {
        Environment = terraform.workspace
    }
}

resource "aws_sns_topic_subscription" "email_sub" {
    count = var.use_email_notification ? 1 : 0
    topic_arn = aws_sns_topic.topic.arn
    protocol = "email"
    endpoint = var.sns_email
}

resource "aws_cloudwatch_metric_alarm" "instance_number" {
    alarm_name = join(": ", ["Active instances for", aws_autoscaling_group.asg.name])
    comparison_operator = "LessThanThreshold"
    evaluation_periods = 1
    metric_name = "GroupTotalInstances"
    namespace = "AWS/AutoScaling"
    period = "180"
    statistic = "Average"
    threshold = aws_autoscaling_group.asg.min_size
    actions_enabled = true
    alarm_actions = [aws_sns_topic.topic.arn]
    ok_actions = [aws_sns_topic.topic.arn]

    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.asg.name
    }

    alarm_description = "This metric monitors running instances"
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization" {
    alarm_name = join(": ", ["CPU utilization", aws_autoscaling_group.asg.name])
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = 1
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "180"
    statistic = "Average"
    threshold = "80"
    actions_enabled = true
    alarm_actions = [aws_sns_topic.topic.arn]
    ok_actions = [aws_sns_topic.topic.arn]

    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.asg.name
    }

    alarm_description = "This metric monitors cpu utilization running instances"
}