# 10.0.0.1 —> 10.0.0.62
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/26"
  enable_dns_hostnames = true

  tags {
    description = "Custom VPC"
  }
}

resource "aws_internet_gateway" "vpc_internet_gateway" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "Internet gateway for the main VPC"
  }
}

resource "aws_route" "public_gateway_access_route" {
  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.vpc_internet_gateway.id}"
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
