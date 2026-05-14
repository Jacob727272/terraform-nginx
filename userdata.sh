#!/bin/bash

apt update -y

apt install nginx -y

systemctl enable nginx

systemctl start nginx

echo "<h1>Welcome from Jenkins Terraform Pipeline</h1>" \
> /var/www/html/index.html
