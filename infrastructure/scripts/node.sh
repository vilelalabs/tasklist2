#!/bin/bash

# ---- Install NodeJS & NPM ------------------------------------------
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Installing Node NPM and Yarn..." >> /home/ec2-user/log.txt
curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
sudo yum install -y nodejs
sleep 5
sudo npm install yarn -g
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> NodeJS & NPM Install Finished!" >> /home/ec2-user/log.txt