resource "aws_instance" "public_instance" {
  ami           = "ami-009110a2bf8d7dd0a"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.subnet_1_public.id}"

  # TODO: Consider how to clean this up
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags {
    description = "Public Web Server"
  }
}
