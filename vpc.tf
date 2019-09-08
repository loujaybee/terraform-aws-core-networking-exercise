# 10.0.0.1 —> 10.0.0.62
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/26"

  tags {
    description = "Custom VPC"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "Internet gateway for the main VPC"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    description = "public route table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    description = "private route table"
  }
}

# 10.0.0.1 —> 10.0.0.30 (public)
resource "aws_subnet" "subnet_1_public" {
  availability_zone = "ap-south-1a"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.0.0.0/27"

  tags {
    description = "Public subnet"
  }
}

resource "aws_route_table_association" "subnet_1_rt_association" {
  subnet_id      = "${aws_subnet.subnet_1_public.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

# 10.0.0.32 —> 10.0.0.48 (private)
resource "aws_subnet" "subnet_2_private" {
  # TODO swap for a data importer
  availability_zone = "ap-south-1a"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.0.0.32/28"

  tags {
    description = "Private subnet 1"
  }
}

resource "aws_route_table_association" "subnet_2_rt_association" {
  subnet_id      = "${aws_subnet.subnet_2_private.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}

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
