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
    bucket       = "wenorgtfstate"             ### example "wenorg"
    key          = "dev/ecs/terraform.tfstate" ###  format should be environment/service.tfstate  Example "stg/user.tfstate"
    region       = "us-west-2"                 ### The S3 state bucket is always in us-west-2 to keep state files in one place 
    use_lockfile = true                        ### dynamodb_table depreciated in terraform v1.10+.  use use_lockfile instead
    encrypt      = true
  }
}
locals {
  current_timestamp = formatdate("YYMMDD", timeadd(timestamp(), 0))
  upper_service     = upper(var.service)
  upper_environment = upper(var.environment)
}