#!/bin/bash
echo -e "\e[1;32mInstalling metricbeat now\e[0m"
curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.5.2-linux-x86_64.tar.gz
tar xzf metricbeat-7.5.2-linux-x86_64.tar.gz

echo -e "\e[1;32mInstalling filebeat now\e[0m"
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.5.2-linux-x86_64.tar.gz
tar xzf filebeat-7.5.2-linux-x86_64.tar.gz

echo -e "\e[1;32mRemoving the archives now\e[0m"
rm -f *.gz

echo -e "\e[1;32mRenaming metricbeat and filebeat...\e[0m"
sudo mv metricbeat-7.5.2-linux-x86_64/ metricbeat
sudo mv filebeat-7.5.2-linux-x86_64/ filebeat

echo -e "\e[1;32mAll done!\e[0m"
