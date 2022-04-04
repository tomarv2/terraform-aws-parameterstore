variable "teamid" {
  description = "Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
  type        = string
}

variable "prjid" {
  description = "Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
  type        = string
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

variable "parameter_write_ignore_values" {
  description = "Feature flag, true or false"
  default     = []
  type        = list(map(string))
}

variable "parameter_write" {
  type        = list(map(string))
  description = "List of maps with the parameter values to write to SSM Parameter Store"
  default     = []
}

variable "custom_tags" {
  type        = any
  description = "Extra custom tags"
  default     = null
}

variable "allowed_pattern" {
  default     = ""
  type        = string
  description = "A regular expression used to validate the parameter value."
}

variable "kms_arn" {
  type        = string
  default     = ""
  description = "The ARN of a KMS key used to encrypt and decrypt SecretString values"
}

variable "parameter_write_defaults" {
  type        = map(any)
  description = "Parameter write default settings"
  default = {
    description     = null
    type            = "String"
    tier            = "Standard"
    overwrite       = "false"
    allowed_pattern = null
    data_type       = "text"
  }
}

variable "ignore_value_changes" {
  type        = map
  description = "Whether to ignore future external changes in paramater values"
  default     = {}
}