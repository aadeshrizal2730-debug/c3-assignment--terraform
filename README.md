# Assignment C3 – Highly Available AWS Application (Terraform)

## Project Overview

This project converts a legacy single-server application into a **highly available and fault-tolerant architecture** on AWS using **Terraform (Infrastructure as Code)**.

The system is designed to continue working even if an **Availability Zone fails**.

---

## Architecture Summary

- **Application Load Balancer (ALB)** – Public entry point
- **EC2 Auto Scaling Group** – Runs web servers across multiple AZs
- **Launch Template** – Bootstraps web server on launch
- **Amazon RDS (Multi-AZ)** – Highly available database
- **AWS SSM Parameter Store (SecureString)** – Stores DB credentials securely

**Traffic Flow:**
# Assignment C3 – Highly Available AWS Application (Terraform)

## Project Overview

This project converts a legacy single-server application into a **highly available and fault-tolerant architecture** on AWS using **Terraform (Infrastructure as Code)**.

The system is designed to continue working even if an **Availability Zone fails**.

---

## Architecture Summary

- **Application Load Balancer (ALB)** – Public entry point
- **EC2 Auto Scaling Group** – Runs web servers across multiple AZs
- **Launch Template** – Bootstraps web server on launch
- **Amazon RDS (Multi-AZ)** – Highly available database
- **AWS SSM Parameter Store (SecureString)** – Stores DB credentials securely

**Traffic Flow:**
