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

# Render a part using a `template_file: 
# https://www.terraform.io/docs/providers/template/d/cloudinit_config.html
data "template_file" "cloud-config-users" {
  template = "${file("${path.module}/templates/cloud-config-users.tpl")}"
  vars = {
    public_key = var.public_key
  }
}

# Render a part using a `template_file: 
data "template_file" "cloud-config-runcmd" {
  template = "${file("${path.module}/templates/cloud-config-runcmd.tpl")}"
  vars = {
    efs_id     = aws_efs_file_system.efs.id
  }
}

# Render a multi-part cloud-init config making use of the part above, and other source files
data "template_cloudinit_config" "cloud-config-users-and-runcmd" {
  part {
    content = "${data.template_file.cloud-config-users.rendered}"
  }
  part {
    content = "${data.template_file.cloud-config-runcmd.rendered}"
  }
}
