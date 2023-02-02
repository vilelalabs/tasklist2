#!/bin/bash

# ---- Install Docker ------------------------------------------
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Installing Docker..." >> /home/ec2-user/log.txt
sudo amazon-linux-extras install docker
sudo service docker start
sleep 5
sudo usermod -aG docker ec2-user
sudo chkconfig docker on
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Docker Install Finished!" >> /home/ec2-user/log.txt
