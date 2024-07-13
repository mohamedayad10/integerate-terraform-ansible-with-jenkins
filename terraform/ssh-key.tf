resource "tls_private_key" "keygen" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.keygen.public_key_openssh
}

resource "local_file" "key" {
  content  = tls_private_key.keygen.private_key_pem
  filename = "${path.module}/${var.private_key_location}"
  provisioner "local-exec" {
    command     = "chmod 400 ./${var.private_key_location}"
    interpreter = ["bash", "-c"]
  }
}