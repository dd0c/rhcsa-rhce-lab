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

$script = <<-SCRIPT
sudo yum install -y ansible
SCRIPT

Vagrant.configure("2") do |config|
	ENV["LC_ALL"] = "en_US.UTF-8"
	ENV["LANG"] = "en_US.UTF-8"

	# configure labipa server
	config.vm.define "labipa" do |node|
		node.vm.box = "centos/7"
		node.vm.hostname = "labipa.example.com"
		node.vm.network "private_network", ip: "172.16.20.50"

		# provider settings for labipa
		node.vm.provider "vagrant-libvirt" do |vbox|
			vbox.customize [
				"modifyvm", :id,
				"--memory", 2048,
				"--cpus", 1,
				"--name", "labipa",
			]
		end

		# provisioning for labipa
		node.vm.provision "shell", inline: $script
		node.vm.provision "ansible_local" do |ansible|
			ansible.playbook = "provision/labipa.yml"
			ansible.host_vars = { "labipa" => { "private_ipv4_address" => "172.16.20.50" }}
		end
	end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
