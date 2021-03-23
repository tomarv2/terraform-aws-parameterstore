resource "aws_ssm_parameter" "default" {
  count = var.deploy_ssm_parameter ? length(var.parameter_write) : 0

  name        = tolist(var.parameter_write)[count.index]["name"]
  description = lookup(tolist(var.parameter_write)[count.index], "description", tolist(var.parameter_write)[count.index]["name"])

  # lookup     -> retrieves the value of a single element from a map, given its key.
  #               If the given key does not exkms_aliasist, a the given default value is returned instead.
  # tolist     -> converts its argument to a list value.
  type   = lookup(tolist(var.parameter_write)[count.index], "type", "SecureString")
  tier   = lookup(var.parameter_write[count.index], "tier", "Standard")
  key_id = lookup(tolist(var.parameter_write)[count.index], "type", "SecureString") == "SecureString" && length(var.kms_alias) > 0 ? var.kms_alias : ""
  value  = tolist(var.parameter_write)[count.index]["value"]

  tags = merge(local.shared_tags)

  depends_on = [var.ssm_depends_on]
}