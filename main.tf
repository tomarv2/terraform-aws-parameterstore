locals {
  parameter_write               = var.ignore_value_changes != {} ? { for e in var.parameter_write : e.name => merge(var.parameter_write_defaults, e) } : {}
  parameter_write_ignore_values = var.parameter_write_ignore_values != {} ? { for e in var.parameter_write_ignore_values : e.name => merge(var.parameter_write_defaults, e) } : {}
}

resource "aws_ssm_parameter" "default" {
  for_each = local.parameter_write
  name     = each.key

  description     = each.value.description
  type            = each.value.type
  tier            = each.value.tier
  key_id          = each.value.type == "SecureString" && length(var.kms_arn) > 0 ? var.kms_arn : ""
  value           = each.value.value
  overwrite       = each.value.overwrite
  allowed_pattern = each.value.allowed_pattern
  data_type       = each.value.data_type
}

resource "aws_ssm_parameter" "ignore_value_changes" {
  for_each = local.parameter_write_ignore_values
  name     = each.key

  description     = each.value.description
  type            = each.value.type
  tier            = each.value.tier
  key_id          = each.value.type == "SecureString" && length(var.kms_arn) > 0 ? var.kms_arn : ""
  value           = each.value.value
  overwrite       = each.value.overwrite
  allowed_pattern = each.value.allowed_pattern
  data_type       = each.value.data_type

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}