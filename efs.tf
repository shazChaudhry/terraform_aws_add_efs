resource "aws_efs_file_system" "efs" {
  creation_token = "EFS Shared Data"
  encrypted      = true
  tags = {
    Name = "EFS Shared Data"
  }
}

resource "aws_efs_mount_target" "efs-target0" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = module.vpc.private_subnets[0]
  security_groups = [module.efs_sg.this_security_group_id]
}

resource "aws_efs_mount_target" "efs-target1" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = module.vpc.private_subnets[1]
  security_groups = [module.efs_sg.this_security_group_id]
}
