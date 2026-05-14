resource "aws_security_group" "nginx_sg" {

  name   = "nginx-security-group"
  vpc_id = "vpc-0ae71fd90d15056ac"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx_server" {

  ami           = var.ami_id
  instance_type = var.instance_type

  key_name = var.key_name

  subnet_id = "subnet-0c373b0b7d59638de"

  vpc_security_group_ids = [
    aws_security_group.nginx_sg.id
  ]

  user_data = file("userdata.sh")

  tags = {
    Name = var.server_name
  }
}
