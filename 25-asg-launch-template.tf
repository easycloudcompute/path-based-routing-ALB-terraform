# Launch Template Resource
resource "aws_launch_template" "my_launch_template" {
  name          = "my_launch_template"
  description   = "my_launch_template"
  image_id      = data.aws_ami.amazonlinux2023.id
  instance_type = var.instance_type

  vpc_security_group_ids = [module.private_sg.security_group_id]
  key_name               = var.instance_keypair
  user_data              = filebase64("${path.module}/app1-install.sh") # Passing user data in base 64 format
  ebs_optimized          = true
  update_default_version = true # When you make a change (say, new AMI or instance type), latest version of launch template gets associated to ASG
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = 10
      delete_on_termination = true
      volume_type           = "gp2" # default  is gp2 
    }
  }
  monitoring {
    enabled = true
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "myasg"
    }
  }

}
