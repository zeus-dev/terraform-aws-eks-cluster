provider "aws" {
  region = "ap-south-1"
}

data "aws_availability_zones" "available" {}

variable "vpc_cidr_blocks" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
}

module "myapp-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.vpc_cidr_blocks

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets  = var.public_subnet_cidr_blocks

  enable_nat_gateway   = true
  enable_vpn_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                  = 1
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"         = 1
  }
}
