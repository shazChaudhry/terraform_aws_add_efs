data "aws_availability_zones" "all" {}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# Get the latest EC2 AMI
data "aws_ami" "latest_amzn_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["amazon"]
}

data "template_file" "cloud-init-efs" {
  template = "${file("${path.module}/cloud-config-efs.tpl")}"
  vars = {
    public_key = var.public_key
    efs_id     = aws_efs_file_system.efs.id
  }
}