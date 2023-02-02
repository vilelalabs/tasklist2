#!/bin/bash

# ---- END ----------------------------------------------------

# Erase files  (scripts, jenkins credentials, aws credentials, jar files and log.sh)
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Erasing temporary files..." >> /home/ec2-user/log.txt
sudo rm -rf /home/ec2-user/scripts
sudo rm -rf /home/ec2-user/.aws
sudo rm -rf /home/ec2-user/*.jar
sudo rm /home/ec2-user/log
sudo rm -rf /home/ec2-user/credentials

echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Finished. Rebooting System in 10 seconds..." >> /home/ec2-user/log.txt

#tempo para testar antes da maquina reiniciar
sleep 10

# Reboot the system to apply sudo permissions
sudo reboot
