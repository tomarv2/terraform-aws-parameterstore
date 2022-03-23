<p align="center">
    <a href="https://github.com/tomarv2/terraform-aws-parameterstore/actions/workflows/pre-commit.yml" alt="Pre Commit">
        <img src="https://github.com/tomarv2/terraform-aws-parameterstore/actions/workflows/pre-commit.yml/badge.svg?branch=main" /></a>
    <a href="https://www.apache.org/licenses/LICENSE-2.0" alt="license">
        <img src="https://img.shields.io/github/license/tomarv2/terraform-aws-parameterstore" /></a>
    <a href="https://github.com/tomarv2/terraform-aws-parameterstore/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-aws-parameterstore" /></a>
    <a href="https://github.com/tomarv2/terraform-aws-parameterstore/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/tomarv2/terraform-aws-parameterstore" /></a>
    <a href="https://stackoverflow.com/users/6679867/tomarv2" alt="Stack Exchange reputation">
        <img src="https://img.shields.io/stackexchange/stackoverflow/r/6679867"></a>
    <a href="https://twitter.com/intent/follow?screen_name=varuntomar2019" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/varuntomar2019?style=social&logo=twitter"></a>
</p>

## Terraform module for [AWS Parameterstore](https://registry.terraform.io/modules/tomarv2/parameterstore/aws/latest)

### Versions

- Module tested for Terraform 1.0.1.
- AWS provider version [3.74](https://registry.terraform.io/providers/hashicorp/aws/latest)
- `main` branch: Provider versions not pinned to keep up with Terraform releases
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-aws-parameterstore/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-aws-parameterstore" /></a> in your releases)

### Usage

#### Option 1:

```
terrafrom init
terraform plan -var='teamid=tryme' -var='prjid=project1'
terraform apply -var='teamid=tryme' -var='prjid=project1'
terraform destroy -var='teamid=tryme' -var='prjid=project1'
```
**Note:** With this option please take care of remote state storage

#### Option 2:

##### Recommended method (stores remote state in S3 using `prjid` and `teamid` to create directory structure):

- Create python 3.8+ virtual environment
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote --upgrade
```

- Set below environment variables:
```
export TF_AWS_BUCKET=<remote state bucket name>
export TF_AWS_BUCKET_REGION=us-west-2
export TF_AWS_PROFILE=<profile from ~/.ws/credentials>
```

or

- Set below environment variables:
```
export TF_AWS_BUCKET=<remote state bucket name>
export TF_AWS_BUCKET_REGION=us-west-2
export AWS_ACCESS_KEY_ID=<aws_access_key_id>
export AWS_SECRET_ACCESS_KEY=<aws_secret_access_key>
```

- Updated `examples` directory with required values.

- Run and verify the output before deploying:
```
tf -c=aws plan -var='teamid=foo' -var='prjid=bar'
```

- Run below to deploy:
```
tf -c=aws apply -var='teamid=foo' -var='prjid=bar'
```

- Run below to destroy:
```
tf -c=aws destroy -var='teamid=foo' -var='prjid=bar'
```

**Note:** Read more on [tfremote](https://github.com/tomarv2/tfremote)
##### SSM Parameterstore (String and SecuredString)
```
module "ssm_parameter" {
  source = "../"

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
```

Please refer to examples directory [link](examples) for references.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.63 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.63 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deploy_ssm_parameter"></a> [deploy\_ssm\_parameter](#input\_deploy\_ssm\_parameter) | Feature flag, true or false | `bool` | `true` | no |
| <a name="input_kms_alias"></a> [kms\_alias](#input\_kms\_alias) | The ARN of a KMS key used to encrypt and decrypt SecretString values | `string` | `"aws/ssm"` | no |
| <a name="input_parameter_write"></a> [parameter\_write](#input\_parameter\_write) | List of maps with the parameter values to write to SSM Parameter Store | `list(map(string))` | `[]` | no |
| <a name="input_prjid"></a> [prjid](#input\_prjid) | Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_split_delimiter"></a> [split\_delimiter](#input\_split\_delimiter) | A delimiter for splitting and joining lists together for normalising the output | `string` | `"~^~"` | no |
| <a name="input_ssm_depends_on"></a> [ssm\_depends\_on](#input\_ssm\_depends\_on) | ssm depends on | `string` | `null` | no |
| <a name="input_teamid"></a> [teamid](#input\_teamid) | Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn_list"></a> [arn\_list](#output\_arn\_list) | List of ARNs created |
| <a name="output_arn_map"></a> [arn\_map](#output\_arn\_map) | A map of the names and ARNs created |
| <a name="output_map"></a> [map](#output\_map) | A map of the names and values created |
| <a name="output_names"></a> [names](#output\_names) | A list of all of the parameter names |
| <a name="output_ssm_account_id"></a> [ssm\_account\_id](#output\_ssm\_account\_id) | ssm deployment account id |
| <a name="output_ssm_aws_region"></a> [ssm\_aws\_region](#output\_ssm\_aws\_region) | ssm deployment region |
| <a name="output_values"></a> [values](#output\_values) | A list of all of the parameter values |
