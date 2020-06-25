# https://registry.terraform.io/modules/terraform-aws-modules/autoscaling

module "public_asg" {
  source = "terraform-aws-modules/autoscaling/aws"
  name   = "jumpbox"

  # Launch configuration
  lc_name         = "jumpbox-lc"
  image_id        = data.aws_ami.latest_amzn_ami.id
  instance_type   = var.instance_type
  user_data       = data.template_file.cloud-init-efs.rendered
  security_groups = [module.public_sg.this_security_group_id]

  # Auto scaling group
  asg_name                  = "jumpbox-asg"
  vpc_zone_identifier       = module.vpc.public_subnets
  health_check_type         = "EC2"
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Terraform"
      value               = "true"
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
  ]
}

module "private_asg" {
  source = "terraform-aws-modules/autoscaling/aws"
  name   = "private-instance"

  # Launch configuration
  lc_name         = "private-instance-lc"
  image_id        = data.aws_ami.latest_amzn_ami.id
  instance_type   = var.instance_type
  user_data       = data.template_file.cloud-init-efs.rendered
  security_groups = [module.private_sg.this_security_group_id]

  # Auto scaling group
  asg_name                  = "private-instance-asg"
  vpc_zone_identifier       = module.vpc.private_subnets
  health_check_type         = "EC2"
  min_size                  = 2
  max_size                  = 2
  desired_capacity          = 2
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Terraform"
      value               = "true"
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
  ]
}