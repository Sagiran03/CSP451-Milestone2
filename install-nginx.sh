#!/bin/bash

# Redirect output and errors to a log file for troubleshooting
exec > /var/log/install-nginx.log 2>&1

echo "Starting Nginx installation..."

# Update package lists and upgrade existing packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install nginx, retry a couple times if fails (network glitches)
for i in {1..3}; do
  if sudo apt-get install nginx -y; then
    echo "Nginx installed successfully."
    break
  else
    echo "Nginx installation failed, retrying in 5 seconds... (attempt $i)"
    sleep 5
  fi
done

# Create web root if missing
sudo mkdir -p /var/www/html

# Deploy a simple Company Portal webpage
cat << EOF | sudo tee /var/www/html/index.html
<html>
  <head><title>Company Portal</title></head>
  <body>
    <h1>Welcome to the Company Portal</h1>
    <p>This page was deployed using Azure ARM Template and Custom Script Extension.</p>
  </body>
</html>
EOF

# Enable and start nginx service
sudo systemctl enable nginx
sudo systemctl start nginx

echo "Nginx installation script finished."
