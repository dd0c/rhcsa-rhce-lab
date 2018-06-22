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

Vagrant.configure("2") do |config|
	ENV["LC_ALL"] = "en_US.UTF-8"
	ENV["LANG"] = "en_US.UTF-8"

	# configure labipa server
	config.vm.define "labipa" do |node|
		node.vm.box = "centos/7"
		node.vm.hostname = "labipa.example.com"
		node.vm.network "private_network", ip: "172.16.20.50"

		# provider settings for labipa
		node.vm.provider "vagrant-libvirt" do |libvirt|
			libvirt.customize [
				"modifyvm", :id,
				"--memory", 2048,
				"--cpus", 1,
				"--name", "labipa",
			]
		end

		# provisioning for labipa
		node.vm.provision "shell", path: "bootstrap_labipa.sh"
		node.vm.provision "file", source: "./ansible", destination: "$HOME/ansible"
	end

	(1..2).each do |i|
		config.vm.define "system#{i}" do |node|
			node.vm.box = "centos/7"
			node.vm.hostname = "system#{i}.example.com"
			node.vm.network "private_network", ip: "172.16.20.5#{i}"

			# provider settings for system1 and system2
			node.vm.provider "vagrant-libvirt" do |libvirt|
				libvirt.customize [
					"modifyvm", :id,
					"--memory", 1024,
					"--cpus", 1,
					"--name", "system#{i}"
				]

				disk_directory = "/var/lib/libvirt/images/"
				disk_name = "disk2.img"
				disk = File.join(disk_directory, "system#{i}", disk_name)
				unless File.exist?(disk)
					libvirt.customize [
						"createhd",
						"--filename", disk,
						"--variant", "Fixed",
						"--format", "qcow2",
						"--size", 2 * 1024
					]
                                        vbox.customize [
                                                "storagectl", :id,
                                                "--name", "SATA Controller",
                                                "--add", "sata",
                                        ]
				end
				libvirt.customize [
					"storageattach", :id,
					"--storagectl", "SATA Controller",
					"--port", 2,
					"--device", 0,
					"--type", "hdd",
					"--medium", disk
				]
			end
		end
	end
end
