variable "environment_id" {
  description = "ID of the stack"
}

variable "environment_name" {
  description = "Friendly name of the stack"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
}

variable "region" {
  default     = "us-east-2"
  description = "AWS Region"
}

variable "zones" {
  type = "list"

  default = [
    "us-east-2a",
    "us-east-2b",
    "us-east-2c",
  ]

  description = "List of availability zones"
}

variable "nat_ami" {
  description = "AMI ID for NAT instance"
}
