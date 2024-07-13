# installing gogs server
resource "aws_instance" "gogs" {
  ami                         = var.image
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.app.id
  associate_public_ip_address = true
  availability_zone           = var.available_zone
  key_name                    = aws_key_pair.generated_key.key_name
  security_groups             = [aws_security_group.gogs.id]
  timeouts {
    create = "5m"
  }
  provisioner "remote-exec" {
    script = "${path.module}/scripts/vm2.sh"

    connection {
      type        = "ssh"
      user        = "ec2-user" # Replace with appropriate SSH user for your AMI
      private_key = tls_private_key.keygen.private_key_pem
      host        = self.public_ip # Replace with your instance's public IP
    }
  }

  tags = {
    Name = "${var.environment}-gogs-server"
  }
}