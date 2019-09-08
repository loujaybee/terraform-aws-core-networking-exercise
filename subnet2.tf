# 10.0.0.32 —> 10.0.0.48 (private)
resource "aws_subnet" "subnet_2_private" {
  # TODO swap for a data importer
  availability_zone = "ap-south-1a"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.subnet_2_private}"

  tags {
    description = "Private subnet 1"
  }
}

resource "aws_route_table_association" "subnet_2_rt_association" {
  subnet_id      = "${aws_subnet.subnet_2_private.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}
