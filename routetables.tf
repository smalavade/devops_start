# Create the route tables

resource "aws_route_table" "web_route_table" {
  vpc_id = aws_vpc.initial_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }

  tags = {
    Name = "Web Server Route Table"
  }
}




resource "aws_default_route_table" "private_rt" {
  default_route_table_id = aws_vpc.initial_vpc.default_route_table_id

  tags = {
    Name = "private"
  }
}

resource "aws_route_table_association" "public_assoc_1" {
  count = 3
  subnet_id      = aws_subnet.web_subnet_1.id
  route_table_id = aws_route_table.web_route_table.id
}

resource "aws_route_table_association" "public_assoc_2" {
  count = 3
  subnet_id      = aws_subnet.web_subnet_2.id
  route_table_id = aws_route_table.web_route_table.id
}


