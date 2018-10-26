variable "aws_region" {
  description = "Region for the VPC"
  default = "us-east-2"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "20.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "20.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default = "20.0.2.0/24"
}

variable "ami" {
  description = "Amazon ubuntu AMI"
  default = "ami-0552e3455b9bc8d50"
}

variable "public_key" {
  description = "SSH Public Key path"
  default = "your key path"
}


