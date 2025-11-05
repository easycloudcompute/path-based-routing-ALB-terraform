module "ec2_private_app2" {
  depends_on             = [module.myvpc]
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "6.0.2"
  name                   = "${var.environment}-app2"
  ami                    = data.aws_ami.amazonlinux2023.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data              = file("${path.module}/app2-install.sh")
  vpc_security_group_ids = [module.private_sg.security_group_id]
  for_each               = toset(["1", "2"]) # toset() used with for_each and converts list into set
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