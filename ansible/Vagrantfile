# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ewe_studio/test_server"
  config.vm.network :private_network, ip: "192.168.128.222"
  config.vm.hostname = "ewe.kvm.test"
  config.ssh.insert_key = false

  config.vm.provider :virtualbox do |v|
    v.memory = 1000
  end

  # Ansible provisioner.
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbooks/vps.kvm.yml"
    ansible.inventory = "inventory.vagrant.yml"
    ansible.vault-password-file = "secrets.txt"
  end
end
