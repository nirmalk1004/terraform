#!/bin/bash
sudo apt update -y &&
sudo apt install -y nginx
echo "Hello World" > /tmp/index.html
sudo cp /tmp/index.html /var/www/html/index.html