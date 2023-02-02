#!/bin/bash

# ---- install Jenkins ------------------------------------------
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Installing Jenkins..." >> /home/ec2-user/log.txt
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install jenkins -y
sudo systemctl daemon-reload
sudo service jenkins start
sleep 5
sudo systemctl enable jenkins
sudo usermod -aG docker jenkins

jenkinsPort=8080
## -- if necessary to change jenkins port --
#jenkins --httpPort=$jenkinsPort

# -- put initialAdminPassword in a file in ~ --
sudo cat /var/lib/jenkins/secrets/initialAdminPassword > /home/ec2-user/initialAdminPassword

# -- download jenkins-cli -- 
sleep 30
cd /home/ec2-user
sudo wget http://localhost:$jenkinsPort/jnlpJars/jenkins-cli.jar


# -- create initial user for Jenkins --
# -- generate random username for Jenkins user -- (TODO: NOT TESTED in machine)
  jUsername=$(tr -dc a-z < /dev/urandom | head -c 6)
  jenkinsUser=$jUsername
# -- generate random password for Jenkins user -- (TODO: NOT TESTED in machine)
  jPassword=$(tr -dc A-Za-z0-9_\!\@\#\$\%\^\&\*\(\)-+= < /dev/urandom | head -c 12)
  jenkinsPassword=$jPassword

sleep 30
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Creating user for Jenkins..." >> /home/ec2-user/log.txt
# fonte do comando abaixo: https://stackoverflow.com/questions/17716242/creating-user-in-jenkins-via-api
pass=`sudo cat initialAdminPassword` && echo "jenkins.model.Jenkins.instance.securityRealm.createAccount('$jenkinsUser', '$jenkinsPassword')" | sudo java -jar jenkins-cli.jar -auth admin:$pass -s http://localhost:$jenkinsPort/ groovy =
# create file with user and password
jenkinsURL="$(cat /home/ec2-user/public_ip.txt):$jenkinsPort"
echo "Jennkins URL: $jenkinsURL" >> /home/ec2-user/jenkins-access.txt
echo "Jenkins User: $jenkinsUser" >> /home/ec2-user/jenkins-access.txt
echo "Password    : $jenkinsPassword" >> /home/ec2-user/jenkins-access.txt

# -- install plugins -- 
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Installing Jenkins plugins..." >> /home/ec2-user/log.txt
plugins_list=$(cat /home/ec2-user/scripts/plugins-list.txt)
sudo java -jar jenkins-cli.jar -auth admin:$pass -s http://localhost:$jenkinsPort/ install-plugin $plugins_list


# -- add github and bitbucket as known hosts to file in ~ --
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Adding github and bitbucket as known hosts..." >> /home/ec2-user/log.txt
ssh-keyscan -H bitbucket.org >> /home/ec2-user/.ssh/known_hosts
ssh-keyscan -H github.com >> /home/ec2-user/.ssh/known_hosts
# -- create script to copy known_hosts to jenkins user --
sudo mkdir /var/lib/jenkins/.ssh
sudo chmod 777 /var/lib/jenkins/.ssh
sudo cp /home/ec2-user/.ssh/known_hosts /var/lib/jenkins/.ssh/known_hosts
sudo chmod 755 /var/lib/jenkins/.ssh

# -- restart Jenkins -- 
sudo java -jar jenkins-cli.jar -auth admin:$pass -s http://localhost:$jenkinsPort/ restart

echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Jenkins Install Finished!" >> /home/ec2-user/log.txt

# -- install standard credentials for bitbucket, slack and another credentials in folder ./credentials --
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Aguardando reinicio do Jenkins..." >> /home/ec2-user/log.txt
sleep 100 # wait for jenkins to restart
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Configurating Jenkins credentials..." >> /home/ec2-user/log.txt
xml_files=$(find ./credentials -name "*.xml")
for file in $xml_files
do
    sudo cat $file | java -jar jenkins-cli.jar -auth admin:$pass -s http://localhost:$jenkinsPort create-credentials-by-xml "SystemCredentialsProvider::SystemContextResolver::jenkins" "(global)"
done

 # -- enables Jenkins to use SCP to copy files to remote server -- all runs in background (&) to not freeze terminal
echo "$(date +%Y-%m-%d\ %H:%M:%S ) -> Configurating Jenkins to use scp command..." >> /home/ec2-user/log.txt
sudo chmod 400 /home/ec2-user/Iac-primeira.pem
sudo cp /home/ec2-user/Iac-primeira.pem  /var/lib/jenkins/Iac-primeira.pem
sudo chown -R jenkins:root /var/lib/jenkins/
echo "$(date +%Y-%m-%d\ %H:%M:%S ) ->  Finish scp configuration for Jenkins." >> /home/ec2-user/log.txt