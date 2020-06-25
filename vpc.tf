# https://registry.terraform.io/modules/terraform-aws-modules/vpc

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "vpc"
  cidr   = "10.0.0.0/26"

  enable_dns_hostnames    = true
  enable_dns_support      = true
  map_public_ip_on_launch = true
  enable_dhcp_options     = true
  # All private subnets will route their Internet traffic through this single NAT gateway. 
  # The NAT gateway will be placed in the first public subnet in your public_subnets block
  single_nat_gateway = true
  enable_nat_gateway = true

  azs             = data.aws_availability_zones.all.names
  private_subnets = ["10.0.0.0/28", "10.0.0.16/28"]
  public_subnets  = ["10.0.0.32/28", "10.0.0.48/28"]

  dhcp_options_domain_name         = var.DnsZoneName
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  dhcp_options_tags = {
    Name = "dhcp"
  }

  vpc_tags = {
    Name = "vpc"
  }

  public_subnet_tags = {
    Name = "public_subnets"
  }

  public_route_table_tags = {
    Name = "public_route_table"
  }

  private_subnet_tags = {
    Name = "private_subnet"
  }

  private_route_table_tags = {
    Name = "private_route_table"
  }

  nat_gateway_tags = {
    Name = "nat_gateway"
  }

  nat_eip_tags = {
    Name = "nat_eip"
  }

  igw_tags = {
    Name = "igw"
  }

  tags = {
    Terraform   = "true"
    Owner       = "user"
    Environment = "development"
  }
}