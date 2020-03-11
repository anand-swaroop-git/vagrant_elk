#!/bin/bash

echo "I will provision your vagrant box!"

echo "\e[1;32mProvisioning started...\e[0m"
apt-get -y update
echo "\e[1;32mapt updated!\e[0m"

echo "\e[1;32mInstalling openjdk-8-jre-headless...\e[0m"
apt-get -y install openjdk-8-jre-headless

echo "\e[1;32mChecking the installed java version...\e[0m"
java -version

echo "\e[1;32mDoing the GPG thing...\e[0m"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

echo "\e[1;32mAdding to the repo list...\e[0m"
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list

echo "\e[1;32mUpdating apt and installing logstash...\e[0m"
apt-get update && apt-get install logstash

#enable on bootup
echo -e "\e[1;32mEnabling ElasticSearch on bootup... \e[0m"
sudo update-rc.d logstash defaults 95 10
sudo systemctl enable logstash

echo -e "\e[1;32mStarting Logstash service now... \e[0m"
sudo service logstash start

echo -e "\e[1;32mSetting the permission for logstash folder so that we can test with ad-hoc command...\e[0m"
sudo chmod -R 777 /usr/share/logstash/data
sudo chmod -R 777 /usr/share/logstash/data/queue

echo -e "\e[1;32mChecking the permission now... \e[0m"
sudo ls -ld /usr/share/logstash/data
sudo ls -ld /usr/share/logstash/data/queue 

echo -e "\e[1;32mTesting the Logstash by running the following command after logging in to the Logstash server:\e[0m"

echo -e "\e[1;31m/usr/share/logstash/bin/logstash -e 'input { stdin { } } output { elasticsearch { hosts => ["10.0.15.10:9200"] } }'\e[0m"
echo
echo
#Installing misc utilities
echo -e "\e[1;32mInstalling jq and tmux now...\e[0m"
sudo apt-get -y install tmux && apt-get -y install jq
echo
echo -e "\e[1;32mThe provisioning of Logstash server has been done!\e[0m"