![ci](https://github.com/MikalaiYatsyna/terraform-aws-vpc/actions/workflows/ci.yml/badge.svg?branch=master)
![lint](https://github.com/MikalaiYatsyna/terraform-aws-vpc/actions/workflows/lint.yml/badge.svg?branch=master)
![sec](https://github.com/MikalaiYatsyna/terraform-aws-vpc/actions/workflows/tfsec.yml/badge.svg?branch=master)

## Introduction
This repository hosts a comprehensive set of Terraform scripts designed to effortlessly provision Virtual Private Clouds (VPCs) within the Amazon Web Services (AWS) environment.

<!-- BEGIN_TF_DOCS -->


## Prerequisites

The following IAM policy needs to be attached to the role that is assumed during the creation of module resources:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sts:GetCallerIdentity",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeVpcs",
        "ec2:DescribeNetworkAcls",
        "ec2:DescribeRouteTables",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeInternetGateways",
        "ec2:DescribeSecurityGroupRules",
        "logs:DescribeLogGroups",
        "ec2:DescribeAddresses",
        "logs:CreateLogDelivery",
        "ec2:DescribeFlowLogs",
        "ec2:DescribeNatGateways",
        "ec2:DescribeNetworkInterfaces"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreateRole",
        "iam:GetRole",
        "iam:ListRolePolicies",
        "iam:ListAttachedRolePolicies",
        "iam:AttachRolePolicy",
        "iam:PassRole",
        "iam:DetachRolePolicy",
        "iam:ListInstanceProfilesForRole",
        "iam:DeleteRole"
      ],
      "Resource": "arn:aws:iam::${AWS::AccountId}:role/vpc-flow-log-role-*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "iam:CreatePolicy",
        "iam:GetPolicy",
        "iam:GetPolicyVersion",
        "iam:ListPolicyVersions",
        "iam:DeletePolicy"
      ],
      "Resource": "arn:aws:iam::${AWS::AccountId}:policy/vpc-flow-log-to-cloudwatch-*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ec2:CreateVpc",
        "ec2:ModifyVpcAttribute",
        "ec2:DescribeVpcAttribute",
        "ec2:DeleteVpc"
      ],
      "Resource": "arn:aws:ec2:*:${AWS::AccountId}:vpc/*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ec2:CreateSubnet",
        "ec2:DeleteSubnet"
      ],
      "Resource": [
        "arn:aws:ec2:*:${AWS::AccountId}:vpc/*",
        "arn:aws:ec2:*:${AWS::AccountId}:subnet/*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "ec2:CreateRouteTable",
        "ec2:DeleteRouteTable"
      ],
      "Resource": [
        "arn:aws:ec2:*:${AWS::AccountId}:vpc/*",
        "arn:aws:ec2:*:${AWS::AccountId}:route-table/*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "ec2:CreateTags"
      ],
      "Resource": [
        "arn:aws:ec2:*:${AWS::AccountId}:vpc/*",
        "arn:aws:ec2:*:${AWS::AccountId}:subnet/*",
        "arn:aws:ec2:*:${AWS::AccountId}:internet-gateway/*",
        "arn:aws:ec2:*:${AWS::AccountId}:route-table/*",
        "arn:aws:ec2:*:${AWS::AccountId}:security-group/*",
        "arn:aws:ec2:*:${AWS::AccountId}:elastic-ip/*",
        "arn:aws:ec2:*:${AWS::AccountId}:natgateway/*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "ec2:CreateRouteTable",
        "ec2:CreateRoute",
        "ec2:DeleteRoute",
        "ec2:DeleteRouteTable"
      ],
      "Resource": [
        "arn:aws:ec2:*:${AWS::AccountId}:route-table/*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "ec2:CreateInternetGateway",
        "ec2:DeleteInternetGateway"
      ],
      "Resource": "arn:aws:ec2:*:${AWS::AccountId}:internet-gateway/*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ec2:AttachInternetGateway",
        "ec2:DetachInternetGateway"
      ],
      "Resource": [
        "arn:aws:ec2:*:${AWS::AccountId}:internet-gateway/*",
        "arn:aws:ec2:*:${AWS::AccountId}:vpc/*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:ListTagsLogGroup",
        "logs:DeleteLogGroup"
      ],
      "Resource": "arn:aws:logs:*:${AWS::AccountId}:log-group:/aws/vpc-flow-log/*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ec2:RevokeSecurityGroupIngress",
        "ec2:RevokeSecurityGroupEgress"
      ],
      "Resource": "arn:aws:ec2:*:${AWS::AccountId}:security-group/*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ec2:AssociateRouteTable",
        "ec2:DisassociateRouteTable"
      ],
      "Resource": [
        "arn:aws:ec2:*:${AWS::AccountId}:route-table/*",
        "arn:aws:ec2:*:${AWS::AccountId}:subnet/*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "ec2:AllocateAddress",
        "ec2:ReleaseAddress",
        "ec2:DisassociateAddress"
      ],
      "Resource": [
        "arn:aws:ec2:*:${AWS::AccountId}:elastic-ip/*",
        "arn:aws:ec2:*:${AWS::AccountId}:*/*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "ec2:CreateFlowLogs",
        "ec2:DeleteFlowLogs"
      ],
      "Resource": [
        "arn:aws:ec2:*:${AWS::AccountId}:vpc-flow-log/*",
        "arn:aws:ec2:*:${AWS::AccountId}:vpc/*"
      ],
      "Effect": "Allow"
    },
    {
      "Action": [
        "ec2:CreateNatGateway",
        "ec2:DeleteNatGateway"
      ],
      "Resource": [
        "arn:aws:ec2:*:${AWS::AccountId}:natgateway/*",
        "arn:aws:ec2:*:${AWS::AccountId}:elastic-ip/*"
      ],
      "Effect": "Allow"
    }
  ]
}
```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.81.0 |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_intra_subnet_ids"></a> [intra\_subnet\_ids](#output\_intra\_subnet\_ids) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR range | `string` | `"10.0.0.0/16"` | no |
| <a name="input_stack"></a> [stack](#input\_stack) | Stack name e.g dev/test/prod | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of additional tags to add to the vpc | `map(string)` | `{}` | no |
| <a name="input_zone_count"></a> [zone\_count](#input\_zone\_count) | Number of availability zones to use | `string` | `2` | no |


## Resources

- data source.aws_availability_zones.available (data.tf#1)
<!-- END_TF_DOCS -->