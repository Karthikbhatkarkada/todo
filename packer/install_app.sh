#!/bin/bash
set -e

sudo apt-get update -y
sudo apt-get install -y nodejs npm

# Extract app
sudo mkdir -p /opt/todoapp
sudo tar xzf /tmp/todoapp.tar.gz -C /opt/todoapp

# Install dependencies inside the app folder
cd /opt/todoapp/todomvc/examples/nodejs-express
sudo npm install --production

# Create a systemd service
sudo bash -c 'cat > /etc/systemd/system/todoapp.service <<EOF
[Unit]
Description=ToDo MVC App
After=network.target

[Service]
ExecStart=/usr/bin/node /opt/todoapp/todomvc/examples/nodejs-express/app.js
Restart=always
User=ubuntu
Environment=PORT=3000
WorkingDirectory=/opt/todoapp/todomvc/examples/nodejs-express

[Install]
WantedBy=multi-user-target
EOF'

sudo systemctl enable todoapp
