IMAGE_NAME = "bento/centos-7"
NODE_NAME = "minikube"

Vagrant.configure(2) do |config|
    config.vm.provider "virtualbox" do |v|
        v.memory = 4096
        v.cpus = 2
    end

    config.vm.network "forwarded_port", guest: 8443, host: 8443, auto_correct: true

    config.vm.define NODE_NAME do |master|
        master.vm.box = IMAGE_NAME

        master.vm.network "private_network", ip: "192.168.56.2"
        master.vm.hostname = NODE_NAME
        # master.vm.provision "ansible_local" do | ansible |
        #     ansible.compatibility_mode = "2.0"
        #     ansible.playbook = "playbooks/ansible-playbook.yaml"
        #     ansible.inventory_path = "inventory/vagrant.hosts"
        #     ansible.extra_vars = {
        #         node_ip: "192.168.50.10",
        #     }
        #     ansible.version = "latest"
        # end
    end
end