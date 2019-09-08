resource "aws_security_group_rule" "allow_tcp_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["${var.subnet_1_public}"]
  security_group_id = "${aws_security_group.allow_http.id}"
}

resource "aws_security_group_rule" "allow_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["${var.subnet_1_public}"]
  security_group_id = "${aws_security_group.allow_http.id}"
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  tags = {
    Name = "HTTP traffic security group"
  }
}
