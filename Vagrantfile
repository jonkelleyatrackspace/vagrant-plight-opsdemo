# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml' 

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
 
# Load configuration from config.yml
conf    = YAML::load_file('config.yml')
nodes   = conf['nodes']
network = conf['network_prefix']
 
puppet_nodes = []
ip_modifier=10
nodes.each { |node_hash|
    ip_modifier += 1
    puppet_nodes << {:hostname => node_hash['hostname'],
                     :ip => "#{network}.#{ip_modifier}",
                     :ipmodifier => "#{ip_modifier}",
                     :box => 'http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box',
                     :guestport => node_hash['guestport'],
                     :hostport => node_hash['hostport']
                    }
}
 
 
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 
  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on the "Usage" link above
    config.cache.scope = :box
 
  end
 
  puppet_nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = node[:box]
      node_config.vm.host_name = node[:hostname]
      node_config.vm.network "forwarded_port", guest: node[:guestport], host: node[:hostport]
      node_config.vm.network "private_network", ip: node[:ip]
      memory = node[:ram] ? node[:ram] : 320;
      node_config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", memory.to_s]
        vb.customize ["modifyvm", :id, "--name", node[:hostname]]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      end
    end
  end

  config.vm.provision "puppet" do |puppet|
    puppet.module_path = "modules"
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "site.pp"
    #puppet.options = "--verbose --debug"
    puppet.facter = {
        "vagrant" => "1",
        "tier"    => 'dev',
        "region"  => 'us',
#        "pwsafe_clear_cache" => 'true',
    }
  end

end
