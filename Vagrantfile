# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Ansible Control Node
  config.vm.define "ansible" do |ansible|
    ansible.vm.box = "ubuntu/jammy64"
    ansible.vm.hostname = "ansible-control"
    ansible.vm.network "private_network", ip: "192.168.56.5"
    
    # Mount the current directory to /vagrant
    ansible.vm.synced_folder ".", "/vagrant"
    
    # Ansible kurulumu için provisioning
    ansible.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y software-properties-common
      apt-get install -y ansible sshpass
    SHELL
  end

  # MySQL Primary Server
  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/jammy64"
    db.vm.hostname = "mysql-primary"
    db.vm.network "private_network", ip: "192.168.56.10"
  end

  # ETL Server
  config.vm.define "etl" do |etl|
    etl.vm.box = "ubuntu/jammy64"
    etl.vm.hostname = "etl-server"
    etl.vm.network "private_network", ip: "192.168.56.11"
  end

  # MySQL Replica Server
  config.vm.define "replica" do |replica|
    replica.vm.box = "ubuntu/jammy64"
    replica.vm.hostname = "mysql-replica"
    replica.vm.network "private_network", ip: "192.168.56.12"
  end
end 