# Module for creating SG for EC2 in private subnet
module "private_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "5.1.0"
  name        = "private-sg"
  description = "Security group with HTTP & SSH ports open for entire VPC, egress ports are all world open"
  vpc_id      = module.myvpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules       = ["ssh-tcp", "http-80-tcp", "http-8080-tcp"] # 8080 is for UMS app
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
}