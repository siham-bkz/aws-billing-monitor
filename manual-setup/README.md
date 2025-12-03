# Manual AWS CLI Setup

Learn AWS services step-by-step by deploying manually. Perfect for understanding how each component works.

## 🎯 Learning Objectives

After completing this guide, you'll understand:
- AWS SNS (Simple Notification Service)
- AWS CloudWatch Alarms
- AWS Billing metrics
- AWS IAM permissions

## 📋 Prerequisites

```bash
# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configure AWS
aws configure
# Enter: AWS Access Key, Secret Key, Region (us-east-1), Output (json)

🚀 Step-by-Step Deployment
Step 1: Create SNS Topic

aws sns create-topic --name aws-billing-topic
# Save the TopicArn from output

Step 2: Subscribe Your Email

aws sns subscribe \
  --topic-arn YOUR_TOPIC_ARN \
  --protocol email \
  --endpoint your@email.com
# Check email and click confirmation link!

Step 3: Create CloudWatch Billing Alarm

aws cloudwatch put-metric-alarm \
  --alarm-name "aws-billing-alert" \
  --alarm-description "Monitor AWS monthly charges" \
  --metric-name "EstimatedCharges" \
  --namespace "AWS/Billing" \
  --statistic "Maximum" \
  --period 21600 \
  --evaluation-periods 1 \
  --threshold 50 \
  --comparison-operator "GreaterThanThreshold" \
  --alarm-actions YOUR_TOPIC_ARN

🔍 Verify Your Setup

# List your alarms
aws cloudwatch describe-alarms --alarm-name-prefix "aws-billing"

# Test notification
aws sns publish \
  --topic-arn YOUR_TOPIC_ARN \
  --message "Test: Manual setup successful!" \
  --subject "Manual Deployment Test"

🧠 Understanding Each Component
AWS SNS (Simple Notification Service)

    Topic: Like a mailing list for notifications

    Subscription: Adding email/phone to receive messages

    Publish: Sending messages to all subscribers

AWS CloudWatch

    Metric: Measurement (EstimatedCharges = your bill)

    Alarm: Watches metrics and triggers actions

    Namespace: Category (AWS/Billing for costs)

AWS Billing

    Updates every 6 hours

    Metric: EstimatedCharges

    Dimension: Currency=USD required

🗑️ Cleanup

# Delete alarm
aws cloudwatch delete-alarms --alarm-names "aws-billing-alert"

# Unsubscribe email
# (Find subscription ARN first)
aws sns list-subscriptions-by-topic --topic-arn YOUR_TOPIC_ARN
aws sns unsubscribe --subscription-arn YOUR_SUBSCRIPTION_ARN

# Delete topic
aws sns delete-topic --topic-arn YOUR_TOPIC_ARN

💡 Pro Tips

    Always check email confirmation after subscribing

    Billing data delays up to 6 hours

    Test with small threshold ($5) to verify quickly

    Use AWS Console to visually see your resources

🎓 Next Steps

After mastering manual setup:

    Try the Terraform deployment

    Experiment with different thresholds

    Add multiple alert levels (warning/critical)

    Integrate with Slack or Teams

This manual approach builds deep understanding that makes you a better DevOps engineer.
