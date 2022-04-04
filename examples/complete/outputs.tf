output "names" {
  value       = module.ssm_parameter.names
  description = "A list of all of the parameter names"
}

output "values" {
  description = "A list of all of the parameter values"
  value       = module.ssm_parameter.values
  sensitive = true
}

output "name_value_map" {
  description = "A map of the names and values created"
  value       = zipmap(module.ssm_parameter.names, module.ssm_parameter.values)
  sensitive = true
}

output "arn_map" {
  description = "List of ARNs created"
  value       = module.ssm_parameter.arn_map
}
