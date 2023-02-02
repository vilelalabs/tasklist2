#!/bin/bash

# ---- Create Log File ----------------------------------------
touch /home/ec2-user/log.txt
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Log Created!" > /home/ec2-user/log.txt

# make a copy of the script to track the installation (and change the name to log.sh)
cp /home/ec2-user/scripts/tracking_install.sh /home/ec2-user/log
sudo chmod +x /home/ec2-user/log
#enables command 'log' to run log.sh
echo "PATH=$PATH:/home/ec2-user/" >> /home/ec2-user/.bashrc


#changes motd to new_motd file content
sudo cp /home/ec2-user/scripts/new_motd /etc/motd
sudo cp /home/ec2-user/scripts/new_motd /etc/motd2
sudo chmod 644 /etc/motd2
echo "cat /etc/motd2" >> /home/ec2-user/.bashrc

#adds command in .bashrc to guarantee scp working
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Echo to .bashrc to ensure scp to work!" > /home/ec2-user/log.txt
echo "[ -z "\$PS1" ] && return" | cat - /home/ec2-user/.bashrc > temp && mv temp /home/ec2-user/.bashrc

# copy run-webserver to user folder
sudo cp /home/ec2-user/scripts/run-webserver.sh /home/ec2-user/run-webserver.sh

#adds run-webserver.sh to crontab
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Updates CRON with run-webserver script!" > /home/ec2-user/log.txt
sudo chmod +x /home/ec2-user/run-webserver.sh
touch temp_cron
echo "* * * * * /home/ec2-user/run-webserver.sh" > temp_cron
crontab -u ec2-user temp_cron
rm temp_cron