# Splitting and joining, and then compacting a list to get a normalised list
locals {
  name_list = compact(
    concat(
      split(
        var.split_delimiter,
        join(var.split_delimiter, aws_ssm_parameter.default.*.name)
      )
    )
  )

  value_list = compact(
    concat(
      split(
        var.split_delimiter,
        join(var.split_delimiter, aws_ssm_parameter.default.*.value)
      )
    )
  )

  arn_list = compact(
    concat(
      split(
        var.split_delimiter,
        join(var.split_delimiter, aws_ssm_parameter.default.*.arn)
      )
    )
  )
}

output "names" {
  value       = local.name_list
  description = "A list of all of the parameter names"
}

output "values" {
  description = "A list of all of the parameter values"
  value       = local.value_list
}

output "map" {
  description = "A map of the names and values created"
  value       = zipmap(local.name_list, local.value_list)
}

output "arn_map" {
  description = "A map of the names and ARNs created"
  value       = zipmap(local.name_list, local.arn_list)
}

output "arn_list" {
  description = "List of ARNs created"
  value       = local.arn_list
}


output "ssm_aws_region" {
  description = "ssm deployment region"
  value       = data.aws_region.current.name
}

output "ssm_account_id" {
  description = "ssm deployment account id"
  value       = data.aws_caller_identity.current.account_id
}
