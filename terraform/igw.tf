resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.app.id

  tags = {
    Name = "${var.environment}-internet-gateway"
  }
}