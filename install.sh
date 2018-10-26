#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo service apache2 start
sudo echo "<html><h1>Hello Terraform</h2></html>" > /var/www/html/index.html
