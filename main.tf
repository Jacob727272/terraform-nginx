resource "aws_instance" "nginx_server" {

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  security_groups = ["default"]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "Jenkins-Nginx-Server"
  }
}
