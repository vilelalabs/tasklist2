resource "null_resource" "send-config-files" {
  provisioner "file" {
    source      = "scripts"
    destination = "/home/ec2-user"
  }

  provisioner "file" {
    source      = "credentials"
    destination = "/home/ec2-user"
  }

  connection {
    host        = aws_instance.task-server.public_ip
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("Iac-primeira.pem")
  }
}
