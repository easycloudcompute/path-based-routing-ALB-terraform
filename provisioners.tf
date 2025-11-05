# Create a Null Resource for Provisioners
resource "null_resource" "copy_ec2_key" {
  depends_on = [module.ec2_bastion_host]

  # Create Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type        = "ssh"
    host        = aws_eip.bastion_eip.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("key-1.pem")
  }

  # file provisioner: Copies the key-1.pem from local to terraform resource after it is crated 
  provisioner "file" {
    source      = "key-1.pem"
    destination = "/tmp/key-1.pem"
  }

  # remote-exec provisioner: To modify permissions of private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [ # Argument used with provisioner to define command to execute
      "sudo chmod 400 /tmp/key-1.pem"
    ]
  }

  # local-exec provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  provisioner "local-exec" {
    command     = "echo VPC created on `date` and VPC ID: ${module.myvpc.vpc_id} >> creation-time-vpc-id.txt" # Store VPC ID in a file 
    working_dir = "local-exec-output-files/"
    #on_failure = continue
  }
}