#!/bin/bash

echo -e "\e[1;32mProvisioning started...\e[0m"
apt-get -y update

echo -e "\e[1;32mInstalling JDK!\e[0m"
sudo apt-get -y install openjdk-8-jre-headless

echo -e "\e[1;32mChecking the installed java version...\e[0m"
java -version

echo -e "\e[1;32mDownloading Elasticsearch now!\e[0m"
sudo wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.8.0-amd64.deb > /dev/null 2>&1

echo -e "\e[1;32mDownload PGP Keys!\e[0m"
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.8.0-amd64.deb.sha512 > /dev/null 2>&1

echo -e "\e[1;32mVerifying Checksum!\e[0m"
shasum -a 512 -c elasticsearch-7.8.0-amd64.deb.sha512

echo -e "\e[1;32mUnpacking!\e[0m"
sudo dpkg -i elasticsearch-7.8.0-amd64.deb

echo -e "\e[1;32mConfiguring for Startup!\e[0m"
sudo update-rc.d elasticsearch defaults 95 10

echo -e "\e[1;32mStarting the Elasticsearch service!\e[0m"
sudo -i service elasticsearch start
sudo systemctl enable elasticsearch

# ### Inject our custom settings in ElasticSearch
echo -e "\e[1;32mEntering custom cluster.name, node.name and network.host...\e[0m"
sudo echo "
cluster.name: andy_test_es_cluster
node.name: es_master
network.host: 0.0.0.0
discovery.seed_hosts: ["127.0.0.1"]" >> /etc/elasticsearch/elasticsearch.yml

echo -e "\e[1;32mSetting max_map_count to 262144... \e[0m"
sysctl -w vm.max_map_count=262144

echo -e "\e[1;32mRestarting the elasticsearch service again..\e[0m"
sudo -i service elasticsearch restart

echo -e "\e[1;32mInstalling jq now...\e[0m"
sudo apt-get -y install jq

echo -e "\e[1;32mVerifying by cURL!\e[0m"
curl -s localhost:9200 | jq .
echo -e "\e[1;32mThe Elasticserach node has been configured!\e[0m"
