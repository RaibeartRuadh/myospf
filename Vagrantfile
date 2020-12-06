# -*- mode: ruby -*-
# vi: set ft=ruby :
# RR

MACHINES = {
  :server1 => {
        :box_name => "centos/7",
        :net => [
{ip: '10.10.0.1', adapter: 2, netmask: "255.255.255.252", virtualbox__intnet: "router1-router2"},
{ip: '10.20.0.1', adapter: 3, netmask: "255.255.255.252", virtualbox__intnet: "router1-router3"},
{ip: '10.40.0.1', adapter: 4, netmask: "255.255.255.0", virtualbox__intnet: "router1-out"}
]
  },
  :server2 => {
        :box_name => "centos/7",
        :net => [
{ip: '10.10.0.2', adapter: 2, netmask: "255.255.255.252", virtualbox__intnet: "router1-router2"},
{ip: '10.30.0.1', adapter: 3, netmask: "255.255.255.252", virtualbox__intnet: "router2-router3"},
{ip: '10.50.0.1', adapter: 4, netmask: "255.255.255.0", virtualbox__intnet: "router2-out"}
]
  },
  :server3 => {
        :box_name => "centos/7",
        :net => [
{ip: '10.20.0.2', adapter: 2, netmask: "255.255.255.252", virtualbox__intnet: "router1-router3"},
{ip: '10.30.0.2', adapter: 3, netmask: "255.255.255.252", virtualbox__intnet: "router2-router3"},
{ip: '10.60.0.1', adapter: 4, netmask: "255.255.255.0", virtualbox__intnet: "router3-out"}
    ]
  }
}

#################################################################################3
Vagrant.configure(2) do |config|
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
          ansible.playbook = "playbook/quagga.yml"
      end
    end
  end
end
