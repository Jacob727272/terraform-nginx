#!/bin/bash
set -eux

exec > /var/log/user-data.log 2>&1

sleep 30

apt-get update -y
apt-get install -y nginx

systemctl enable nginx
systemctl start nginx

echo "<h1>Welcome from Jenkins Terraform Pipeline</h1>" > /var/www/html/index.html
