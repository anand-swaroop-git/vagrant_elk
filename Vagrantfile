# Defines our Vagrant environment

#

# -*- mode: ruby -*-

# vi: set ft=ruby :


Vagrant.configure("2") do |config|

  # create elasticsearch node

  config.vm.define :elasticsearch do |elasticsearch_config|
      elasticsearch_config.vm.box = "ubuntu/xenial64"
      elasticsearch_config.vm.hostname = "elasticsearch"
      elasticsearch_config.vm.network :private_network, ip: "10.0.15.10"
      elasticsearch_config.vm.provider "virtualbox" do |vb|
        vb.memory = "3096"
      end
      elasticsearch_config.vm.provision :shell, path: "provision_elasticsearch.sh"
  end
  
  # create logstash node

  config.vm.define :logstash do |logstash_config|
    logstash_config.vm.box = "ubuntu/xenial64"
    logstash_config.vm.hostname = "logstash"
    logstash_config.vm.network :private_network, ip: "10.0.15.11"
    logstash_config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    logstash_config.vm.provision :shell, path: "provision_logstash.sh"
end

  # create kibana node

  config.vm.define :kibana do |kibana_config|
    kibana_config.vm.box = "ubuntu/xenial64"
    kibana_config.vm.hostname = "kibana"
    kibana_config.vm.network :private_network, ip: "10.0.15.12"
    kibana_config.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
    kibana_config.vm.provision :shell, path: "provision_kibana.sh"
end

end