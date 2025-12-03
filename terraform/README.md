# Terraform Deployment

Professional Infrastructure as Code deployment for AWS Billing Monitor.

## 📋 Prerequisites

- **AWS Account** with billing access enabled
- **AWS CLI** configured with credentials
- **Terraform** v1.12.2 or later

## 🚀 Quick Deployment

```bash
cd terraform

# Initialize Terraform
terraform init

# Plan deployment (see what will be created)
terraform plan -var="alert_email=your@email.com"

# Apply configuration
terraform apply -var="alert_email=your@email.com"

⚙️ Configuration Variables

Create terraform.tfvars file:

alert_email       = "your@email.com"
billing_threshold = 50  # USD
alarm_name        = "aws-billing-alert"

terraform apply \
  -var="alert_email=your@email.com" \
  -var="billing_threshold=30"

🏗️ Infrastructure Created

This Terraform configuration creates:

    AWS SNS Topic: aws-billing-topic

    Email Subscription: Your specified email

    CloudWatch Alarm: Monitors EstimatedCharges metric

    IAM Permissions: Required for monitoring

🔍 Verification

After deployment:
# Check created resources
terraform show

# Test notification system
aws sns publish \
  --topic-arn $(terraform output -raw sns_topic_arn) \
  --message "Test: Billing monitor active" \
  --subject "System Test"
🗑️ Cleanup

# Destroy all resources
terraform destroy

🆘 Troubleshooting

Issue	Solution
"Access Denied"	Check IAM permissions for CloudWatch and SNS
Email not confirmed	Check spam folder, click confirmation link
No billing data	Wait 6 hours (billing updates every 6h)


📚 Learn More


    See ../manual-setup/README.md for manual AWS CLI approach

    AWS Billing Documentation

    Terraform AWS Provider
