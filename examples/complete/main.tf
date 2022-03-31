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
      name        = "/security/demo"
      value       = "WORLD"
      type        = "String"
      overwrite   = "true"
      description = "hello world string"
    },
    {
      name        = "/security/demo-secured"
      value       = "helloworld"
      type        = "SecureString"
      overwrite   = "true"
      description = "hello world secured string"
    }
  ]
  kms_alias = "alias/aws/ssm"
  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
