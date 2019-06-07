#!/bin/bash

echo -e "\e[1;32mProvisioning started...\e[0m"
apt-get -y update
echo -e "\e[1;32mapt updated!\e[0m"

echo -e "\e[1;32mInstalling openjdk-8-jre-headless... \e[0m"
apt-get -y install openjdk-8-jre-headless

echo -e "\e[1;32mChecking the installed java version... \e[0m"
java -version

echo -e "\e[1;32mDownloading and installing ElasticSearch...\e[0m"
### Check http://www.elasticsearch.org/download/ for latest version of ElasticSearch and replace wget link below
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.16.deb > /dev/null 2>&1

echo -e "\e[1;32mSleeping for 15 seconds...\e[0m"
sleep 15

echo -e "\e[1;32mDownload complete... Installing now... \e[0m"
sudo dpkg -i elasticsearch-5.6.16.deb

#enable on bootup
echo -e "\e[1;32mEnabling ElasticSearch on bootup... \e[0m"
sudo update-rc.d elasticsearch defaults 95 10
sudo systemctl enable elasticsearch
 
### Start ElasticSearch 
echo -e "\e[1;32mStarting ElasticSearch service... \e[0m"
sudo /etc/init.d/elasticsearch start

### Make sure service is running
echo -e "\e[1;32mValidating if ElasticSearch is running properly...\e[0m"
systemctl is-active elasticsearch


### Inject our custom settings in ElasticSearch
echo -e "\e[1;32mEntering custom cluster.name, node.name and network.host...\e[0m"
sudo echo "
cluster.name: andy-test
node.name: andy-es01
network.host: 10.0.15.10" >> /etc/elasticsearch/elasticsearch.yml

echo -e "\e[1;32mForce reload the service...\e[0m"
sudo /etc/init.d/elasticsearch restart

echo -e "\e[1;32mSleeping for 15 seconds...\e[0m"
sleep 15


echo -e "\e[1;32mFinally checking if the HTTP endpoint is working as expected...\e[0m"
curl -s /dev/null http://10.0.15.10:9200 2>&1

### Should return something like this:
# {
#   "name" : "andy-es01",
#   "cluster_name" : "andy-test",
#   "cluster_uuid" : "gtd1xa_DS5Ogvdk0InOIHw",
#   "version" : {
#     "number" : "5.6.16",
#     "build_hash" : "3a740d1",
#     "build_date" : "2019-03-13T15:33:36.565Z",
#     "build_snapshot" : false,
#     "lucene_version" : "6.6.1"
#   },
#   "tagline" : "You Know, for Search"
# }

echo -e "\e[1;32mSetting max_map_count to 262144...\e[0m"
sysctl -w vm.max_map_count=262144

echo -e "\e[1;32mThe Elasticserach node has been configured!\e[0m"
