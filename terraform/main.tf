resource "aws_sns_topic" "aws_billing" {
  name = "aws-billing-topic"
}


resource "aws_sns_topic_subscription" "billing_email" {
  topic_arn = aws_sns_topic.aws_billing.arn
  protocol  = "email"
  endpoint  = var.email_alert # Your email
  
  # Wait for email confirmation
  confirmation_timeout_in_minutes = 10
}




resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name                = "aws-watching-alarm"
  alarm_description         = "Monitor AWS monthly charges exceeding budget"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "EstimatedCharges"
  namespace                 = "AWS/Billing"
  period                    = "21600"
  statistic                 = "Maximum"
  threshold                 = var.billing_threshold
  alarm_actions = [aws_sns_topic.aws_billing.arn]

  dimensions = {
    Currency = "USD"  # ← REQUIRED for billing alarms
  }
}