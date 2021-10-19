variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
  type        = string
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
  type        = string
}

variable "parameter_write" {
  type        = list(map(string))
  description = "List of maps with the parameter values to write to SSM Parameter Store"
  default     = []
}

variable "split_delimiter" {
  type        = string
  default     = "~^~"
  description = "A delimiter for splitting and joining lists together for normalising the output"
}

variable "kms_alias" {
  type        = string
  default     = "aws/ssm"
  description = "The ARN of a KMS key used to encrypt and decrypt SecretString values"
}

variable "ssm_depends_on" {
  description = "ssm depends on"
  default     = null
  type        = string
}

variable "deploy_ssm_parameter" {
  description = "feature flag, true or false"
  default     = true
  type        = bool
}
