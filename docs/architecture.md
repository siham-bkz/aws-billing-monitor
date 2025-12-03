# System Architecture

## Overview
AWS Billing Monitor is a cost protection system that alerts users when AWS spending exceeds defined thresholds.

## Components

### 1. AWS CloudWatch
- **Metric Alarm**: Monitors `EstimatedCharges` metric
- **Frequency**: Checks every 6 hours (21600 seconds)
- **Threshold**: User-defined (default: $50 USD)
- **Namespace**: `AWS/Billing` with `Currency=USD` dimension

### 2. AWS SNS (Simple Notification Service)
- **Topic**: Central messaging hub
- **Subscription**: Email endpoint for notifications
- **Protocol**: Email with confirmation requirement

### 3. Terraform (Infrastructure as Code)
- **Provider**: AWS
- **State Management**: Tracks resource lifecycle
- **Variables**: Configurable parameters
AWS Billing Data → CloudWatch Metric → Alarm Evaluation → SNS Topic → Email Notification
↓ ↓ ↓ ↓ ↓
Cost Metrics Every 6 hours Cost > Threshold Message Hub User Inbox


## Security Considerations
- **IAM**: Minimum required permissions
- **Sensitive Data**: Email addresses as variables
- **State File**: Contains resource metadata (store securely)
