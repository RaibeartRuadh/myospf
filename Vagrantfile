# -*- mode: ruby -*-
# vi: set ft=ruby :
# RR

MACHINES = {
    
    :server1 => {  
        :box_name => "centos/7",
        :net => [
{ip: '172.16.12.11', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "netlink"},
{ip: '172.16.16.11', adapter: 3, netmask: "255.255.255.0", virtualbox__intnet: "netlink"},
]    
    },

    :server2 => {  
        :box_name => "centos/7",
        :net => [
{ip: '172.16.12.12', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "netlink"},
{ip: '172.16.20.12', adapter: 3, netmask: "255.255.255.0", virtualbox__intnet: "netlink"},
]    
    },
    
    :server3 => {  
        :box_name => "centos/7",
        :net => [
{ip: '172.16.16.13', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "netlink"},
{ip: '172.16.20.13', adapter: 3, netmask: "255.255.255.0", virtualbox__intnet: "netlink"},
]    
    },
}

#################################################################################3
Vagrant.configure(2) do |config|

  config.vm.define "server1" do |c|
    c.vm.network "forwarded_port", adapter: 1, guest: 22, host: 2321, id: "ssh", host_ip: '127.0.0.1'
  end
  config.vm.define "server2" do |c|
    c.vm.network "forwarded_port", adapter: 1, guest: 22, host: 2322, id: "ssh", host_ip: '127.0.0.1'
  end
  config.vm.define "server3" do |c|
    c.vm.network "forwarded_port", adapter: 1, guest: 22, host: 2323, id: "ssh", host_ip: '127.0.0.1'
  end

  MACHINES.each do |boxname, boxconfig|
    config.vm.define boxname do |box|
        box.vm.box = boxconfig[:box_name]
        box.vm.box_check_update = false
        box.vm.host_name = boxname.to_s
        boxconfig[:net].each do |ipconf|
          box.vm.network "private_network", ipconf
        end
        box.vm.provider "virtualbox" do |v|
          v.memory = "512"
          v.cpus = "1"
        end
        box.vm.network 'public_network', boxconfig[:public] if boxconfig.key?(:public)
        box.vm.provision "shell", path: "config/sshscript.sh"

        box.vm.provision "ansible" do |ansible|
          ansible.playbook = "playbook/common.yml"
        end
        box.vm.provision "ansible" do |ansible|
          ansible.playbook = "playbook/quagga.yml"
      end
    end
  end
end
