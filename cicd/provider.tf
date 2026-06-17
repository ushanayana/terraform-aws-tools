terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.37.0"
    }
  }
  backend "s3" {
    bucket = "daws-78s-eks"
    key    = "jenkins"
    region = "us-east-1"
    #dynamodb_table = "daws78s-locking"
    use_lockfile = true
  }
}

#provide authentication here
provider "aws" {
  region = "us-east-1"
}