# Assignment C3 – Highly Available and Fault-Tolerant AWS Application (Terraform)

## Project Overview

This project demonstrates how to design and deploy a **highly available and fault-tolerant application stack** on AWS using **Terraform (Infrastructure as Code)**.

A legacy single EC2 instance and database are re-architected to support **multi-AZ availability**, **automatic recovery**, and **secure configuration management**.

---

## Architecture Overview

**Main Components:**
- Application Load Balancer (ALB)
- EC2 Auto Scaling Group (Multi-AZ)
- Launch Template with user-data bootstrap
- Amazon RDS with Multi-AZ enabled
- AWS Systems Manager Parameter Store (SecureString)
- Virtual Private Cloud (VPC) with public and private subnets

**Traffic Flow:**
Internet
↓
Application Load Balancer (Public Subnets)
↓
EC2 Auto Scaling Group (Private Subnets, Multi-AZ)
↓
Amazon RDS (Multi-AZ)


---

## How High Availability Is Achieved

- EC2 instances run across multiple Availability Zones
- Auto Scaling Group replaces failed instances automatically
- Application Load Balancer distributes traffic and performs health checks
- RDS Multi-AZ provides automatic database failover
- No single point of failure exists in the architecture

---

## Terraform File Structure and Explanation

### `providers.tf`
- Configures the AWS provider
- Defines the AWS region and provider version

---

### `vpc.tf`
- Creates the VPC
- Defines public and private subnets across multiple AZs
- Configures Internet Gateway and route tables
- Enables internet access for the ALB while keeping EC2 private

---

### `security-groups.tf`
- ALB security group allows HTTP traffic from the internet
- EC2 security group allows HTTP traffic **only from the ALB**
- RDS security group allows database access only from EC2 instances

---

### `asg-alb.tf`
- Creates the Application Load Balancer
- Configures the target group and health checks
- Creates an Auto Scaling Group distributed across AZs
- Attaches the ASG to the ALB target group
- Ensures automatic instance replacement on failure

---

### `launch-template.tf` (or inside `asg-alb.tf`)
- Defines the EC2 Launch Template
- Includes user-data to:
  - Install web server
  - Start the service automatically
  - Create a sample application page

---

### `rds.tf`
- Creates an Amazon RDS database
- Enables Multi-AZ for high availability
- Uses private subnets
- Restricts access using security groups

---

### `outputs.tf`
- Displays important infrastructure values
- Outputs the ALB DNS name used to access the application

---

### `.gitignore`
- Prevents sensitive and generated files from being committed
- Excludes Terraform state files and provider cache

---

## Deployment Steps

### 1. Clone the Repository
```bash
git clone https://github.com/<your-username>/c3-assignment--terraform.git
cd c3-assignment--terraform

After all this integration , i then did

> terraform init ; to initialize terraform
> terraform validate ; to validate the configuration
> terraform plan ; to review the execution plan
> terraform apply ; to deploy the infrastructure

Testing Fault Tolerance
~Web Tier Failover

~Terminate an EC2 instance from the Auto Scaling Group

~Application remains available

~ASG automatically launches a replacement instance

~Database Failover

~RDS Multi-AZ automatically promotes the standby instance if the primary fails


FOR CLEANUP : terraform destroy
