# Module for creating SG for Bastion Host
module "public_bastion_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "5.1.0"
  name        = "bastion-host-sg"
  description = "Security group for bastion-host-sg with ssh port open as inbound for all and open for all for outbound"
  vpc_id      = module.myvpc.vpc_id

  # Ingress Rules & CIDR Blocks
  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
}