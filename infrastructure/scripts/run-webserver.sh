#!/bin/bash

# prepara cron para quando receber o script the run do webserver
if test -f /home/ec2-user/start_webserver.sh; then
  sudo chmod +x /home/ec2-user/start_webserver.sh;
  sudo sh /home/ec2-user/start_webserver.sh;
  sudo rm -rf /home/ec2-user/start_webserver.sh;
  echo "Last Webserver Update: $(date +%Y-%m-%d\ %H:%M:%S )" > /home/ec2-user/webserver_updates.txt
fi