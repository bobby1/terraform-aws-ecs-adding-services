terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = var.region
  default_tags { ### tags to be applied to all resources
    tags = {
      business_division = var.business_division
      environment       = var.environment
      service           = var.service
    }
  }
}
terraform {
  backend "s3" {
    bucket         = "wenorg"                           ### example "wenorg"
    key            = "dev/ecs/terraform.tfstate"        # key            = "<environment>/<service>.tfstate" ###  format should be environment/service.tfstate  Example "stg/user.tfstate"
    region         = "us-west-1"                        ### The S3 state bucket is always in us-west-2 to keep state files in one place 
    dynamodb_table = "wenorg-dev-ecs-terraform-locking" ### The DynamoDB table is keyed on LockID which is set as a bucketName/path. This is to prevent concurrent writes to the state file
    encrypt        = true
  }
}
locals {
  current_timestamp = formatdate("YYMMDD", timeadd(timestamp(), 0))
  upper_service     = upper(var.service)
  upper_environment = upper(var.environment)
}