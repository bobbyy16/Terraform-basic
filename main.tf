provider "aws" {}

variable "subnet_cidr_block" {
  description = "subnet cidr block"
#   default = "10.0.10.0/24"
#   type = list(string) 
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
}

variable "environment" {
  description = "Development environment"
}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name: "development"
    vpc_env: var.environment
  }
}

resource "aws_subnet" "development-subent-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "ap-south-1a"
  tags = {
     Name = "development-subent-1"
  }
}

data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "development-subent-2" {
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = "172.31.48.0/20"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "subent-2-default"
  }
}

output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
}

output "dev-subent-id" {
    value = aws_subnet.development-subent-1.id
}