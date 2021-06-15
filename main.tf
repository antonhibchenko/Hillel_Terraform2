//project main file
provider "aws" {
  region  = "eu-central-1"
}

locals {
  common_tags = {
    Purpose = "Terraform guru :D"
    Project = "Hillel"
  }
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  tags     = local.common_tags
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
  instance_type = var.instance_type
  subnet_id = module.vpc.public_networks[1]
  eip_attach = var.eip_attach
  volume_size = var.volume_size
  aws_key_pair = var.aws_key_pair
}