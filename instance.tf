resource "aws_instance" "public_instance" {
  ami                         = "ami-02913db388613c3e1"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.allow_http.id}"]
  subnet_id                   = "${aws_subnet.subnet_1_public.id}"
  associate_public_ip_address = true

  # TODO: Consider how to clean this up
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install httpd -y
              service httpd start
              chkconfig httpd on
              echo "Hello World" >> /var/www/html/index.html
              EOF

  tags {
    description = "Public Web Server"
  }
}
