resource "aws_instance" "task-server" {
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
  key_name      = "Iac-primeira"

  user_data = file("user_data.sh")

  tags = {
    Name = "task-server"
  }
}