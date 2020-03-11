#!/bin/bash
echo -e "\e[1;32mProvisioning started...\e[0m"
apt-get -y update

echo -e "\e[1;32mInstalling JDK!\e[0m"
sudo apt-get -y install openjdk-8-jre-headless

echo -e "\e[1;32mChecking the installed java version...\e[0m"
java -version

echo -e "\e[1;32mAdding GPG Key\e[0m"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

echo -e "\e[1;32mSave the repository definition to /etc/apt/sources.list.d/elastic-7.x.list\e[0m"
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

echo -e "\e[1;32mInstalling the apt-transport-https package\e[0m"
sudo apt-get install apt-transport-https

echo "\e[1;32mUpdating apt and installing logstash...\e[0m"
apt-get update && apt-get -y install logstash

echo -e "\e[1;32mSetting the permission for logstash folder so that we can test with ad-hoc command...\e[0m"
sudo chown -R vagrant:vagrant /usr/share/logstash/
sudo chmod -R 700 /usr/share/logstash/data
sudo chmod -R 700 /usr/share/logstash/data/queue

echo -e "\e[1;32mMaking config directory for Logstash configs...\e[0m"
mkdir /usr/share/logstash/config

echo -e "\e[1;32mCreating the sample config file now...\e[0m"
touch /usr/share/logstash/config/inp_beat_out_elk.conf

echo -e "\e[1;32mEntering custom config in the config file...\e[0m"
sudo echo "
input {
  beats {
    port => 5044
  }
}
output {
stdout { codec => rubydebug }
  elasticsearch{
    hosts => ["http://10.0.15.10:9200"]
  }
}" >> /usr/share/logstash/config/inp_beat_out_elk.conf

echo -e "\e[1;32mCreating a demo config file which will have sample commands...\e[0m"
touch  /usr/share/logstash/config/inp_stdin_filter_out_elk.conf
sudo echo "
# /usr/share/logstash/bin/logstash -e 'input { stdin { } } filter {mutate {split => ["message"," "]}} output { stdout { codec => rubydebug } elasticsearch { hosts => ["10.0.15.10:9200"] } }'


input {
  stdin {}
}
filter { 
  mutate { 
    split => ["message"," "]
    }
}
output {
stdout { codec => rubydebug }
  elasticsearch{
    hosts => ["http://10.0.15.10:9200"]
  }
}" >> /usr/share/logstash/config/inp_stdin_filter_out_elk.conf


echo -e "\e[1;32mChecking the permission now...\e[0m"
sudo ls -ld /usr/share/logstash/data
sudo ls -ld /usr/share/logstash/data/queue 

echo -e "\e[1;32mTesting the Logstash by running the following command after logging in to the Logstash server:\e[0m"

echo -e "\e[1;31m/usr/share/logstash/bin/logstash -e 'input { stdin { } } output { stdout { codec => rubydebug } elasticsearch { hosts => ["10.0.15.10:9200"] } }'\e[0m"
echo
echo
#Installing misc utilities
echo -e "\e[1;32mInstalling jq and tmux now...\e[0m"
sudo apt-get -y install tmux && apt-get -y install jq
echo
echo -e "\e[1;32mThe provisioning of Logstash server has been done!\e[0m"

