resource "aws_instance" "jenkins" {
  ami                         = var.image
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.app.id
  associate_public_ip_address = true
  availability_zone           = var.available_zone
  key_name                    = aws_key_pair.generated_key.key_name
  security_groups             = [aws_security_group.jenkins.id]
  depends_on                  = [aws_instance.app, aws_instance.gogs]

  provisioner "remote-exec" {
    script = "${path.module}/scripts/vm1.sh"

    connection {
      type        = "ssh"
      user        = "ec2-user" # Replace with appropriate SSH user for your AMI
      private_key = tls_private_key.keygen.private_key_pem
      host        = self.public_ip # Use self to dynamically refer to the instance's public IP
    }
  }

  tags = {
    Name = "${var.environment}-jenkins-server"
  }
}
