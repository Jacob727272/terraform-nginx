#!/bin/bash

apt update -y
apt install nginx -y

systemctl enable nginx
systemctl start nginx

echo "<h1>NGINX Installed from Jenkins + Terraform</h1>" \
> /var/www/html/index.html
