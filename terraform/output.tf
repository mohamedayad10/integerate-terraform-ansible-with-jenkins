output "ec2-public-ip" {
  value = aws_instance.app.public_ip
}