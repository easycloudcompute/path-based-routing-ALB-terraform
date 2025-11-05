# Get latest AMI ID 
data "aws_ami" "amazonlinux2023" {
  most_recent = true
  owners      = ["amazon"]
  filter { # Attribute to retrieve specific resources based on defined criteria
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]

  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}