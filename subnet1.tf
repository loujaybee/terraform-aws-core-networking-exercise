# 10.0.0.1 —> 10.0.0.30 (public)
resource "aws_subnet" "subnet_1_public" {
  availability_zone       = "ap-south-1a"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.subnet_1_public}"
  map_public_ip_on_launch = true

  tags {
    description = "Public subnet"
  }
}

resource "aws_route_table_association" "subnet_1_rt_association" {
  subnet_id      = "${aws_subnet.subnet_1_public.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}
