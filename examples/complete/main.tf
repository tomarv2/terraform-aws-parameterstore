terraform {
  required_version = ">= 1.0.1"
  required_providers {
    aws = {
      version = "~> 3.74"
    }
  }
}

provider "aws" {
  region = var.region
}

module "ssm_parameter" {
  source = "../../"

  parameter_write = [
    {
      name        = "demo"
      value       = "password"
      description = "demo password"
    }
  ]

  parameter_write_ignore_values = [
    {
      name        = "hello"
      value       = "world"
      description = "hello world string"
    }
  ]
  kms_alias = "alias/aws/ssm"
  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}


