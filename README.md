## Introduction
Terraform module to AWS VPC

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.54.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR range | `string` | `"10.0.0.0/16"` | no |
| <a name="input_intra_subnet_tags"></a> [intra\_subnet\_tags](#input\_intra\_subnet\_tags) | A map of additional tags to add to the intra subnets | `map(string)` | n/a | yes |
| <a name="input_private_subnet_tags"></a> [private\_subnet\_tags](#input\_private\_subnet\_tags) | A map of additional tags to add to the private subnets | `map(string)` | n/a | yes |
| <a name="input_public_subnet_tags"></a> [public\_subnet\_tags](#input\_public\_subnet\_tags) | A map of additional tags to add to the public subnets | `map(string)` | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | Stack name e.g dev/test/prod | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of additional tags to add to the vpc | `map(string)` | `{}` | no |
| <a name="input_zone_count"></a> [zone\_count](#input\_zone\_count) | Number of availability zones to use | `number` | `2` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->