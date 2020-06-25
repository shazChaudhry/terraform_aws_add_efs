# https://registry.terraform.io/modules/terraform-aws-modules/security-group

module "public_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "public-sg"
  description = "public SG"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"] # This range should ideally be limited to say your home address
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]

  tags = {
    Name        = "public-sg"
    Terraform   = "true"
    Environment = "dev"
  }
}

module "private_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "private-sg"
  description = "private SG"
  vpc_id      = module.vpc.vpc_id

  # Only accept ssh connection from the public subnet
  ingress_with_source_security_group_id = [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = module.public_sg.this_security_group_id
    },
  ]
  # Traffic to outside world will be routed through a NAT gateway
  egress_rules = ["all-all"]


  tags = {
    Name        = "private-sg"
    Terraform   = "true"
    Environment = "dev"
  }
}

module "efs_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "efs-sg"
  description = "efs SG"
  vpc_id      = module.vpc.vpc_id

  # Only accept ssh connection from the private subnet
  ingress_with_source_security_group_id = [
    {
      rule                     = "nfs-tcp"
      source_security_group_id = module.private_sg.this_security_group_id
    },
  ]
  egress_rules = ["all-all"]

  tags = {
    Name        = "efs-sg"
    Terraform   = "true"
    Environment = "dev"
  }
}