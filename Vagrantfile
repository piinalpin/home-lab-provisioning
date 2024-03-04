IMAGE_NAME = "bento/centos-7"
NODE_NAME = "centos-minikube"

Vagrant.configure(2) do |config|
    config.vm.provider "virtualbox" do |v|
        v.memory = 4096
        v.cpus = 2
    end

    config.vm.define NODE_NAME do |master|
        master.vm.box = IMAGE_NAME

        master.vm.network "private_network", ip: "192.168.56.2"
        master.vm.hostname = NODE_NAME
    end
end