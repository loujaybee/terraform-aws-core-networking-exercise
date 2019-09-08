# 10.0.0.48 —> 10.0.0.62 (private)
resource "aws_subnet" "subnet_3_private" {
  availability_zone = "ap-south-1a"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.0.0.48/28"

  tags {
    description = "Private subnet 2"
  }
}

resource "aws_route_table_association" "subnet_3_rt_association" {
  subnet_id      = "${aws_subnet.subnet_3_private.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}
