resource "aws_security_group" "gogs" {
  vpc_id = aws_vpc.app.id

  # Ingress rule allowing SSH access only from your IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.app.cidr_block, var.my_public_ip]
  }
  # Ingress rule allowing gogs access
  ingress {
    from_port   = 3000
    to_port     = 3000
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
    Name = "${var.environment}-gogs_security_group"
  }
}