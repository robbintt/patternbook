# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  
  # using multiple VMs in one Vagrantfile - conditional stuff
  # http://www.thisprogrammingthing.com/2015/multiple-vagrant-vms-in-one-vagrantfile/
  # the linked post says they use a google sheet to track hostname, IP Address, and name for each of their Vagrantfile machines
  # VM with a unique: hostname, IP Address, and name
  config.vm.define "servers" do |servers|
    servers.vm.box = "ubuntu/xenial64"
    servers.vm.hostname = "servers"
    # box_url unnecessary if the box variable is in hashicorp cloud
    #servers.vm.box_url = "ubuntu/xenial64"
    # https://www.vagrantup.com/docs/networking/private_network.html
    # https://www.vagrantup.com/docs/virtualbox/networking.html
    servers.vm.network :private_network, ip: "192.168.50.100"
    # i did not end up using this
    # instead i use the hosts file to specify the IP of the private_network machines I wish to configure
    #servers.vm.provider :virtualbox do |v|
    #  v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    #  v.customize ["modifyvm", :id, "--memory", 512]
    #  v.customize ["modifyvm", :id, "--name", "servers"]
    #end
    # provisioning with ansible:
    # http://docs.ansible.com/ansible/latest/guide_vagrant.html
    # https://www.vagrantup.com/docs/provisioning/ansible.html
    # i guess we don't need to specify hosts
    # also i guess vagrant will never upgrade at the same time as other hosts
    # since the vagrant ansible stuff always gets run through `vagrant provision`
    # note that this is unnecessary as we can put the local host into `hosts`
    # this keeps us from going to deep into this vagrant file, instead
    # simply using it to provision the host in virtualbox, not for maintenance...
    servers.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.playbook = "servers.yml"
      ansible.ask_vault_pass = true
      ansible.inventory_path = "hosts"
    end
  end

  # another VM with a different: hostname, IP Address, and name
  config.vm.define "databases" do |databases|
    databases.vm.box = "ubuntu/xenial64"
    databases.vm.hostname = "databases"
    # box_url unnecessary if the box variable is in hashicorp cloud
    # databases.vm.box_url = "ubuntu/xenial64"
    # https://www.vagrantup.com/docs/networking/private_network.html
    # https://www.vagrantup.com/docs/virtualbox/networking.html
    databases.vm.network :private_network, ip: "192.168.50.101"
    databases.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "databases"]
    end
  end

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = "ubuntu/xenial64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

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
