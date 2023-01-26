variable "region" {
  description = "AWS Region"
  default     = "us-east-2"
}

variable "name" {
  type        = string
  description = "VPC name"
}

variable "cidr" {
  description = "CIDR range"
  default     = "10.0.0.0/16"
}

variable "zone_count" {
  description = "Number of availability zones to use"
  default     = 2
}

variable "tags" {
  description = "A map of additional tags to add to the vpc"
  type        = map(string)
  default     = {}
}

variable "public_subnet_tags" {
  description = "A map of additional tags to add to the public subnets"
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "A map of additional tags to add to the private subnets"
  type        = map(string)
  default     = {}
}