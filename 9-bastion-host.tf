# Module for creating Bastion Host 
module "ec2_bastion_host" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "6.0.2"
  name                   = "${var.environment}-bastion-host"
  ami                    = data.aws_ami.amazonlinux2023.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  subnet_id              = module.myvpc.public_subnets[0] # 0 means bastion host is created in the first subnet
  user_data              = file("${path.module}/jumpbox-configure.sh")
}