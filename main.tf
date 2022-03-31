resource "aws_ssm_parameter" "default" {
  count = var.deploy_ssm_parameter ? length(var.parameter_write) : 0

  name        = tolist(var.parameter_write)[count.index]["name"]
  description = lookup(tolist(var.parameter_write)[count.index], "description", tolist(var.parameter_write)[count.index]["name"])

  type      = lookup(tolist(var.parameter_write)[count.index], "type", "SecureString")
  tier      = lookup(var.parameter_write[count.index], "tier", "Standard")
  key_id    = lookup(tolist(var.parameter_write)[count.index], "type", "SecureString") == "SecureString" && length(var.kms_alias) > 0 ? var.kms_alias : ""
  value     = tolist(var.parameter_write)[count.index]["value"]
  overwrite = lookup(var.parameter_write[count.index], "overwrite", false)

  allowed_pattern   = var.allowed_pattern
  tags              = var.custom_tags != null ? merge(var.custom_tags, local.shared_tags) : merge(local.shared_tags)

  # This module assumes that value is changed manually.
  # using AWS Management Console or AWS CLI, should prevent plan diff occurring.
  #
  # That's because we want to manage SSM Parameter settings with Terraform.
  # But, we do not want to manage the value itself (especially in case of sensitive value) with Terraform.
  # In other words, sensitive value that is written into the tf file should not be managed by the Version Control System.
  #
  # NOTE: If you want to reference the value itself in Terraform code, then use aws_ssm_parameter of Data Source.
  lifecycle {
    ignore_changes = [value]
  }
}
