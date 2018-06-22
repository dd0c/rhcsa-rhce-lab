# -*- mode: ruby -*-
# vi: set ft=ruby :

# file     : Vagrantfile
# purpose  : Emulation of a RHEL7 RHCSA an RHCE lab environment
#
# author   : tycho alexander docter
# date     : 20180613
# version  : v1.0
#
# changelog:
# - v1.0     initial version
# - v1.1    
#
#
Vagrant.configure("2") do |config|
	ENV["LC_ALL"] = "en_US.UTF-8"
	ENV["LANG"] = "en_US.UTF-8"

	# configure labipa server
	config.vm.define :labipa do |node|
		node.vm.box = "centos/7"
		node.vm.hostname = "labipa.example.com"
		node.vm.network "private_network", ip: "172.16.20.50"

		node.vm.provider :libvirt do |libvirt|
			libvirt.memory = 2048
			libvirt.cpus = 1
		end
		node.vm.provision "shell", path: "bootstrap_labipa.sh"
		node.vm.provision "file", source: "./ansible", destination: "$HOME/ansible"
	end

	# configure client/server nodes
	(1..2).each do |i|
		config.vm.define "system#{i}" do |node|
			node.vm.box = "centos/7"
			node.vm.hostname = "system#{i}.example.com"
			node.vm.network "private_network", ip: "172.16.20.5#{i}"

			node.vm.provider :libvirt do |libvirt|
				libvirt.memory = 1024
				libvirt.cpus = 1
				libvirt.storage :file, :size => '1G'
			end
		end
	end
end
