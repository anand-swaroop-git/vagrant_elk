# Defines our Vagrant environment

#

# -*- mode: ruby -*-

# vi: set ft=ruby :

elasticsearch_ip = "10.0.15.10"
elastic_memory = "3096"
logstash_ip = "10.0.15.11"
logstash_memory = "2048"
kibana_ip = "10.0.15.12"
kibana_memory = "512"


Vagrant.configure("2") do |config|

  # create elasticsearch node

  config.vm.define :elasticsearch do |elasticsearch_config|
      elasticsearch_config.vm.box = "ubuntu/xenial64"
      elasticsearch_config.vm.hostname = "elasticsearch"
      elasticsearch_config.vm.network :private_network, ip: elasticsearch_ip
      elasticsearch_config.vm.provider "virtualbox" do |vb|
        vb.memory = elastic_memory
      end
      elasticsearch_config.vm.provision :shell, path: "provision_elasticsearch.sh"
  end
  
  # create logstash node

  config.vm.define :logstash do |logstash_config|
    logstash_config.vm.box = "ubuntu/xenial64"
    logstash_config.vm.hostname = "logstash"
    logstash_config.vm.network :private_network, ip: logstash_ip
    logstash_config.vm.provider "virtualbox" do |vb|
      vb.memory = logstash_memory
    end
    logstash_config.vm.provision :shell, path: "provision_logstash.sh"
end

  # create kibana node

  config.vm.define :kibana do |kibana_config|
    kibana_config.vm.box = "ubuntu/xenial64"
    kibana_config.vm.hostname = "kibana"
    kibana_config.vm.network :private_network, ip: kibana_ip
    kibana_config.vm.provider "virtualbox" do |vb|
      vb.memory = kibana_memory
    end
    kibana_config.vm.provision :shell, path: "provision_kibana.sh"
end

end

puts "-------------------------------------------------"
puts "Elasticsearch_Endpoint   : http://#{elasticsearch_ip}:9200/"
puts "Logstash IP              : #{logstash_ip}"
puts "Kibana_Endpoint          : http://#{kibana_ip}:5601/"
puts "-------------------------------------------------"