locals {
  shared_tags = tomap(
    {
      "Name"    = "${var.teamid}-${var.prjid}",
      "team"    = var.teamid,
      "project" = var.prjid
    }
  )
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
