# Autoscaling Group Resource
resource "aws_autoscaling_group" "my_asg" {
  name_prefix         = "myasg-"
  desired_capacity    = 2
  max_size            = 4
  min_size            = 2
  vpc_zone_identifier = module.myvpc.private_subnets
  target_group_arns   = [module.alb.target_groups["mytg1"].arn] # Associate ASG to ALB
  health_check_type   = "EC2"

  # Associate Launch Template with ASG
  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = aws_launch_template.my_launch_template.latest_version
  }

  # Instance Refresh - Allows Rolling deployments of EC2's while keeping the app available 
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"] # You can add any argument from ASG here, if those has changes, ASG Instance Refresh will trigger   
  }
  tag {
    key                 = "Owners"
    value               = "Dev"
    propagate_at_launch = true # Enables propagation of the tag to Amazon EC2 instances launched via this ASG
  }
}