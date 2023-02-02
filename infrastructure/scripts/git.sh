#!/bin/bash

# ---- Install Git ------------------------------------------
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Installing Git..." >> /home/ec2-user/log.txt
sudo yum install git -y
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Git Install Finished!" >> /home/ec2-user/log.txt