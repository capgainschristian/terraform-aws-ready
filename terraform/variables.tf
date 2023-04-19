##### Setting up the AWS infrastructure #####

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Region that will be used within the terraform module."
}

variable "vpc_name" {
  type        = string
  default     = "wg_vpc"
  description = "VPC for the WG instance."
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  default = {
    "private_subnet_1" = 1
    "private_subnet_2" = 2
  }
}

variable "public_subnets" {
  default = {
    "public_subnet_1" = 1
    "public_subnet_2" = 2
  }
}

variable "variables_sub_cidr" {
  description = "CIDR Block for the Variables Subnet"
  type        = string
  default     = "10.0.202.0/24"
}

variable "variables_sub_az" {
  description = "Availability Zone used for Variables Subnet"
  type        = string
  default     = "us-east-1a"
}

variable "variables_sub_auto_ip" {
  description = "Set Automatic IP Assigment for Variables Subnet"
  type        = bool
  default     = true
}

variable "date_format" {
  type        = string
  default     = "MM-DD-YYYY"
  description = "Format used for tagging instances and keys"
}

##### Setting up the instance #####
variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Type of instance that will be used for the WG deployment."
}

variable "aws_labels" {
  type        = string
  default     = "aws_wireguard"
  description = "Label that will be used across TF for all resources related to WG."
}

variable "default_tags" {
  type = map(string)
  default = {
    Description = "Wireguard VPN for personal use."
    Provider    = "AWS."
    Team        = "Graham_Summit_LLC"

  }
}