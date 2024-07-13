resource "aws_subnet" "app" {
  vpc_id            = aws_vpc.app.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.available_zone

  tags = {
    Name = "${var.environment}-subnet"
  }
}