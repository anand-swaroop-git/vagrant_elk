#!/bin/bash
echo -e "\e[1;32mProvisioning now... \e[0m"
echo
echo -e "\e[1;32mDoing the GPG thing... \e[0m"
sudo wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

echo -e "\e[1;32mAdding to the repo list... \e[0m"
sudo echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

echo -e "\e[1;32mUpdating apt and installing kibana... \e[0m"
apt-get update && apt-get install kibana

### Inject our custom settings in Kibana
echo -e "\e[1;32mEntering custom server.host, server.name and elasticsearch.url now...\e[0m"
sudo echo "
server.host: \"10.0.15.12\"
server.name: \"andy-kibana01\"
elasticsearch.hosts: \"http://10.0.15.10:9200\"" >> /etc/kibana/kibana.yml
echo
echo
#enable on bootup
echo -e "\e[1;32mEnabling Kibana on bootup... \e[0m"
sudo update-rc.d kibana defaults 95 10
sudo systemctl enable kibana

echo -e "\e[1;32mStarting Kibana service now... \e[0m"
sudo service kibana start

echo -e "\e[1;32mChecking Kibana service status... \e[0m"
sudo service kibana status

echo -e "\e[1;32mThe provisioning of Kibana server has been done!\e[0m"
