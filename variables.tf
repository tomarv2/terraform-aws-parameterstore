variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
}

variable "profile_to_use" {
  description = "Getting values from ~/.aws/credentials"
  default     = "default"
}

variable "parameter_write" {
  type        = list(map(string))
  description = "List of maps with the parameter values to write to SSM Parameter Store"
  default     = []
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to `false` to prevent the module from creating and accessing any resources"
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
  default = null
}

variable "aws_region" {
  description = "aws region to create resources"
  default     = "us-west-2"
}

variable "deploy_ssm_parameter" {
  description = "feature flag, true or false"
  default     = true
  type        = bool
}
