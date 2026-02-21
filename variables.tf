variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR for the main VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "allowed_ip_cidr" {
  type = string
}

variable "ssh_public_key_path" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}
