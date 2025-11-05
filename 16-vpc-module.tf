module "myvpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  # VPC Basic Details

  name            = var.vpc_name
  cidr            = var.vpc_cidr_block
  azs             = var.vpc_availability_zones
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  # Options for database subnets

  database_subnets                   = var.vpc_database_subnets
  create_database_subnet_group       = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table

  # NAT Gateways for private subnets for Outbound Communication
  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway # Single NAT Gateway per AZ , Mutiple will incur more costs and its more for a HA setup

  # VPC DNS Parameters
  enable_dns_hostnames = true # Allows EC2 with public ip to get a public DNS hostname
  enable_dns_support   = true # Allows instances inside VPC to resolve public DNS names using AWS's internal DNS server at 169.254.169.253

  # Define tags

  public_subnet_tags = {
    Type = "public-subnets"
  }

  private_subnet_tags = {
    Type = "private-subnets"
  }

  database_subnet_tags = {
    Type = "database-subnets"
  }

  vpc_tags = {
    Name = "dev-vpc"
  }
}