# Create Elastic IP for Bastion Host
resource "aws_eip" "bastion_eip" {
  depends_on = [module.ec2_bastion_host, module.myvpc]
  instance   = module.ec2_bastion_host.id
  domain     = "vpc"

  ## Local Exec Provisioner that is triggered during deletion of resource and records the destroy time
  provisioner "local-exec" {
    command     = "echo Destroy time prov `date` >> destroy-time-prov.txt"
    working_dir = "local-exec-output-files/"
    when        = destroy
    #on_failure = continue
  }
}