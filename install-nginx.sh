#!/bin/bash

# Update and install Nginx
sudo apt update -y && sudo apt upgrade -y
sudo apt install nginx -y

# Create simple company portal page
echo "<html>
  <head><title>Company Portal</title></head>
  <body>
    <h1>Welcome to the Company Portal</h1>
    <p>This page was deployed using Azure ARM Template and Custom Script Extension.</p>
  </body>
</html>" | sudo tee /var/www/html/index.html

# Start and enable nginx
sudo systemctl start nginx
sudo systemctl enable nginx
