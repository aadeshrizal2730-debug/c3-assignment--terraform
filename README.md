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

- I run this project using Ubuntu 24-04 linux system in Windows Powershell ; so initially i had to install terraform and awscli , and configure the aws that i wanted
  to connect using "aws get-stscaller-identity" and then given the AMI and secret AM key ; configured with the aws account.
  
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
### Step 1: Install Required Tools

Make sure the following tools are installed:

- AWS CLI
- Terraform
- Git

Check installation:
```bash
aws --version
terraform --version
git --version

Step 2: Configure AWS Credentials

Login to AWS and configure credentials locally:

aws configure
Enter:

AWS Access Key ID

AWS Secret Access Key

Default region (example: us-east-1)

Output format: json

Terraform uses these credentials to create AWS resources.
Step 3: Clone the GitHub Repository
git clone https://github.com/<your-username>/c3-assignment--terraform.git
cd c3-assignment--terraform

Step 4: Verify Terraform Files Exist

Confirm all Terraform files are present:

ls


You should see files such as:

providers.tf

vpc.tf

security-groups.tf

asg-alb.tf

rds.tf

outputs.tf

Step 5: Initialize Terraform

This downloads the AWS provider and prepares Terraform:

terraform init


You should see:

Terraform has been successfully initialized!

Step 6: Validate Terraform Configuration

Ensure there are no syntax errors:

terraform validate


Expected output:

Success! The configuration is valid.

Step 7: Review the Execution Plan

See what resources Terraform will create:

terraform plan


No resources are created at this stage.

Step 8: Deploy the Infrastructure

Apply the Terraform configuration:

terraform apply


When prompted, type:

yes

Step 9: Verify Auto Scaling

Go to AWS Console:

EC2 → Auto Scaling Groups

Confirm instances are Healthy

Instances are running in multiple AZs

step 10: Testing Fault Tolerance
~Web Tier Failover

~Terminate an EC2 instance from the Auto Scaling Group

~Application remains available

~ASG automatically launches a replacement instance

~Database Failover

~RDS Multi-AZ automatically promotes the standby instance if the primary fails


FOR CLEANUP : terraform destroy
