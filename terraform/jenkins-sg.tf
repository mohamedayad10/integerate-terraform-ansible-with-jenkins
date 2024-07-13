resource "aws_security_group" "jenkins" {
  vpc_id = aws_vpc.app.id

  # Ingress rule allowing SSH access only from your IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.app.cidr_block, var.my_public_ip]
  }
  # Ingress rule allowing http access
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.app.cidr_block, var.my_public_ip]
  }
  # Egress rule allowing all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-jenkins_security_group"
  }
}