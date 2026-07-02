# 🚀 Terraform AWS Infrastructure Project

![Terraform](https://img.shields.io/badge/Terraform-v1.x-purple)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange)
![GitHub](https://img.shields.io/badge/GitHub-Repository-black)
![Status](https://img.shields.io/badge/Status-Completed-success)

---

# 📖 Project Overview

This project demonstrates how to provision AWS infrastructure using **Terraform Infrastructure as Code (IaC)**.

The project creates the following AWS resources:

- Amazon VPC
- Public Subnet
- Private Subnet
- Internet Gateway
- Public Route Table
- Private Route Table
- Route Table Associations
- Security Group
- EC2 Instance

The Terraform State is stored remotely in an **Amazon S3 Bucket**, making it suitable for team collaboration.

---

# 🏗️ Architecture

```

                 Internet
                     │
             Internet Gateway
                     │
      ------------------------------
      │                            │
   Public Route Table        Private Route Table
      │                            │
Public Subnet              Private Subnet
      │
 EC2 Instance
      │
 Security Group
      │
      VPC

```

---

# 📁 Project Structure

```

Terraform-AWS/
│
├── backend.tf
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── vpc.tf
├── outputs.tf
├── .gitignore
├── README.md
└── .terraform.lock.hcl

```

---

# 🛠 Technologies Used

- Terraform
- AWS
- AWS CLI
- Amazon EC2
- Amazon VPC
- Internet Gateway
- Route Tables
- Security Groups
- Amazon S3
- Git
- GitHub
- Visual Studio Code

---

# 📋 Prerequisites

Install the following software before starting.

## 1. Install Git

Download:

https://git-scm.com/downloads

Verify

```bash
git --version
```

---

## 2. Install Visual Studio Code

Download

https://code.visualstudio.com/

Recommended Extensions

- HashiCorp Terraform
- AWS Toolkit
- GitLens

---

## 3. Install Terraform

Download

https://developer.hashicorp.com/terraform/downloads

Verify

```bash
terraform --version
```

---

## 4. Install AWS CLI

Download

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

Verify

```bash
aws --version
```

---

# 🔑 Configure AWS Credentials

Run

```bash
aws configure
```

Provide

```

AWS Access Key ID

AWS Secret Access Key

AWS Region

Output Format

```

Example

```

AWS Access Key ID: AKIAxxxxxxxxxxxx

AWS Secret Access Key: *********************

Default Region: us-east-1

Output Format: json

```

Verify

```bash
aws sts get-caller-identity
```

---

# 📂 Clone Repository

```bash
git clone https://github.com/HemangiSA/Terraform-AWS.git
```

Go inside project

```bash
cd Terraform-AWS
```

---

# ⚙ Backend Configuration

Terraform stores its State File remotely in Amazon S3.

Example

```hcl
terraform {

  backend "s3" {

    bucket = "dev-env-2july-terraform"

    key = "terraform.tfstate"

    region = "us-east-1"

    encrypt = true

    use_lockfile = true

  }

}
```

### Explanation

| Property | Description |
|----------|-------------|
| bucket | Amazon S3 Bucket Name |
| key | Terraform State File Name |
| region | AWS Region |
| encrypt | Encrypt State File |
| use_lockfile | Prevent multiple users modifying state simultaneously |

---

# 📦 Initialize Terraform

```bash
terraform init
```

Purpose

- Downloads Provider Plugins
- Initializes Backend
- Downloads Required Modules

---

# ✅ Validate Configuration

```bash
terraform validate
```

Purpose

Checks syntax errors.

---

# 🎨 Format Code

```bash
terraform fmt
```

Purpose

Formats Terraform code according to Terraform standards.

---

# 🔍 Generate Execution Plan

```bash
terraform plan
```

Purpose

Shows

- Resources to Create
- Resources to Update
- Resources to Destroy

---

# 🚀 Create Infrastructure

```bash
terraform apply
```

Type

```
yes
```

Terraform creates all AWS resources.

---

# 📋 View Terraform State

```bash
terraform state list
```

Shows all resources managed by Terraform.

---

# 📄 Show Terraform State

```bash
terraform show
```

Displays detailed information about deployed resources.

---

# 🔄 Reconfigure Backend

If backend configuration changes

```bash
terraform init -reconfigure
```

---

# 🔀 Migrate Existing State

```bash
terraform init -migrate-state
```

Used when migrating state to a different backend.

---

# ❌ Destroy Infrastructure

```bash
terraform destroy
```

Type

```
yes
```

Deletes all AWS resources created by Terraform.

---

# 📤 Common Terraform Commands

```bash
terraform init
```

```bash
terraform validate
```

```bash
terraform fmt
```

```bash
terraform plan
```

```bash
terraform apply
```

```bash
terraform destroy
```

```bash
terraform state list
```

```bash
terraform show
```

```bash
terraform output
```

```bash
terraform providers
```
terraform apply --auto-approve //auto apply without asking yes/no
terraform destroy --auto-approve
---

# ☁ AWS Resources Created

- Amazon VPC
- Public Subnet
- Private Subnet
- Internet Gateway
- Public Route Table
- Private Route Table
- Route Table Associations
- Security Group
- EC2 Instance

---

# 🔒 Git Ignore

The following files should **NOT** be committed.

```
.terraform/
*.tfstate
*.tfstate.*
crash.log
*.tfvars
```

---

# 📚 Learning Objectives

This project demonstrates:

- Terraform Basics
- Variables
- Providers
- Resources
- Dependencies
- State Management
- Remote Backend
- AWS Networking
- EC2 Deployment
- Infrastructure as Code
- Git Integration

---

# 📸 Screenshots

Add screenshots here:

- Terraform Init
- Terraform Plan
- Terraform Apply
- AWS Console
- EC2 Instance
- VPC
- Route Tables
- S3 Backend

---

# 👩‍💻 Author

**Hemangi Ahire**

GitHub

https://github.com/HemangiSA

---



# ⭐ If you found this project helpful

Please consider giving this repository a ⭐ on GitHub.