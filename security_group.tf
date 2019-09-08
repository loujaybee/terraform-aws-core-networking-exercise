resource "aws_security_group_rule" "allow_all" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  security_group_id = "${aws_security_group.allow_http.id}"
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow TLS inbound traffic"

  tags = {
    Name = "HTTP traffic security group"
  }
}
