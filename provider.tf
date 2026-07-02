terraform {
  required_version = ">= 1.15.0" 
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

###############################################################################
# Terraform Backend Configuration
#
# Backend is used to store the Terraform State File remotely instead of locally.
#
# Advantages:
# ✔ Centralized State Management
# ✔ Team Collaboration
# ✔ State File Backup
# ✔ State Locking
# ✔ Prevents State Corruption
###############################################################################

terraform {

  ###########################################################################
  # Configure Amazon S3 as the Remote Backend
  ###########################################################################
  backend "s3" {

    # -----------------------------------------------------------------------
    # S3 Bucket Name
    #
    # This bucket stores the terraform.tfstate file.
    #
    # Bucket must already exist before running:
    #
    # terraform init
    #
    # Example:
    # dev-env-2july-terraform
    # -----------------------------------------------------------------------
    bucket = "dev-env-2july-terraform"

    # -----------------------------------------------------------------------
    # Key (Object Path)
    #
    # Specifies the filename (or folder path) inside the S3 bucket.
    #
    # Example:
    # terraform.tfstate
    #
    # You can also organize by environment:
    #
    # dev/terraform.tfstate
    # qa/terraform.tfstate
    # prod/terraform.tfstate
    # -----------------------------------------------------------------------
    key = "terraform.tfstate"

    # -----------------------------------------------------------------------
    # AWS Region
    #
    # Region where the S3 bucket is created.
    #
    # Terraform looks for the bucket in this region.
    # -----------------------------------------------------------------------
    region = "us-east-1"

    # -----------------------------------------------------------------------
    # Enable Server-Side Encryption
    #
    # true  -> Encrypts the Terraform State File in S3.
    # false -> Stores state without encryption.
    #
    # Recommended:
    # Always keep this TRUE in production.
    # -----------------------------------------------------------------------
    encrypt = true

    # -----------------------------------------------------------------------
    # Enable State Locking
    #
    # Prevents multiple users from modifying the state simultaneously.
    #
    # When one user runs:
    #
    # terraform apply
    #
    # Terraform creates a lock.
    #
    # Other users must wait until the first operation finishes.
    #
    # This helps avoid:
    #
    # • State corruption
    # • Concurrent modifications
    # • Resource conflicts
    #
    # Note:
    # In older Terraform versions, state locking for the S3 backend was
    # typically implemented using a DynamoDB table.
    # The 'use_lockfile' option is supported only in newer Terraform versions.
    # -----------------------------------------------------------------------
    use_lockfile = true
  }
}