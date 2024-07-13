resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.app.id
  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.gw.id # Reference the ID of the internet gateway

  }
  tags = {
    Name = "${var.environment}-route-table"
  }
}

resource "aws_route_table_association" "route_table_associate" {
  subnet_id      = aws_subnet.app.id
  route_table_id = aws_route_table.route_table.id
}