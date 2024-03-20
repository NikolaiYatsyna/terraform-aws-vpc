variable "stack" {
  type        = string
  description = "Stack name e.g dev/test/prod"
}

variable "cidr" {
  type        = string
  description = "CIDR range"
  default     = "10.0.0.0/16"
}

variable "zone_count" {
  type        = string
  description = "Number of availability zones to use"
  default     = 2
}

variable "tags" {
  description = "A map of additional tags to add to the vpc"
  type        = map(string)
  default     = {}
}
