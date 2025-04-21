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
    # bucket       = "<bucket_name>"             ### example "wenorg"
    # key          = "<statefile name>" ###  format should be environment/service.tfstate  Example "stg/user.tfstate"
    # region       = "<AWS S3 bucket region>"                 ### The S3 state bucket is always in us-west-2 to keep state files in one place 
    use_lockfile = true
    encrypt      = true
  }
}
locals {
  current_timestamp = formatdate("YYMMDD", timeadd(timestamp(), 0))
  upper_service     = upper(var.service)
  upper_environment = upper(var.environment)
}