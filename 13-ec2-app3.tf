module "ec2_private_app3" {
  depends_on             = [module.myvpc]
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "6.0.2"
  name                   = "${var.environment}-app3"
  ami                    = data.aws_ami.amazonlinux2023.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data              = templatefile("app3-ums-install.tmpl", { rds_db_endpoint = module.rdsdb.db_instance_address })
  vpc_security_group_ids = [module.private_sg.security_group_id]
  for_each               = toset(["1", "2"])
  # Dyanmically allocate subnets
  # If module.myvpc.private_subnets returns ["subnet-aaa111", "subnet-bbb222"] 
  # Terraform will produce:
  # For "1" → subnet_id = subnet-aaa111
  # For "2" → subnet_id = subnet-bbb222     
  # Since each.key is a string, we convert it to a number :
  # tonumber("1") → 0
  # tonumber("2") → 1
  subnet_id = element(module.myvpc.private_subnets, tonumber(each.key))
  # Create 2 EC2's with tags : private-ec2-app2-1 and private-ec2-app2-2
  tags = local.tags
}