output "ec2_bastion_public_ip" {
  description = "Public Ip of bastion host"
  value       = module.ec2_bastion_host.public_ip
}

output "ec2-app1-private-ip" {
  description = "Private IP of ec2-app1"
  value       = [for a in module.ec2_private_app1 : a.private_ip]
}

output "ec2-app2-private-ip" {
  description = "Private IP of ec2-app1"
  value       = [for a in module.ec2_private_app2 : a.private_ip]
}

output "ec2-app3-private-ip" {
  description = "Private IP of ec2-app1"
  value       = [for a in module.ec2_private_app3 : a.private_ip]
}