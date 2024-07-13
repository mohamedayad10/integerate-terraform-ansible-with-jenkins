# installing app server
resource "aws_instance" "app" {
  ami                         = var.image
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.app.id
  associate_public_ip_address = true
  availability_zone           = var.available_zone
  key_name                    = aws_key_pair.generated_key.key_name
  security_groups             = [aws_security_group.app.id]
  user_data                   = file("scripts/installdocker.sh")
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ${path.module}/ssh-file/app_public_ip.txt"
  }
  tags = {
    Name = "${var.environment}-app-server"
  }
  connection {
    type        = "ssh"
    user        = "ec2-user" # Replace with appropriate SSH user for your AMI
    private_key = tls_private_key.keygen.private_key_pem
    host        = aws_instance.app.public_ip # Replace with your instance's public IP
  }
}

resource "null_resource" "assign_user_to_group" {
  depends_on = [aws_instance.app]
  connection {
    type        = "ssh"
    user        = "ec2-user" # Replace with appropriate SSH user for your AMI
    private_key = tls_private_key.keygen.private_key_pem
    host        = aws_instance.app.public_ip # Replace with your instance's public IP
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/CreateUsers.sh"
  }
}