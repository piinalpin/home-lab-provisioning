IMAGE_NAME = "ubuntu/focal64"
MASTER_NODE_IP = "192.168.56.2"
MASTER_SSH_FORWARDED_PORT = 2722
WORKER_NODE_IPS = ["192.168.56.3", "192.168.56.4"]

Vagrant.configure(2) do |config|
    # Configure box
    config.vm.box = IMAGE_NAME
    config.vm.box_check_update = false

    # Provision Master Node
    config.vm.define "master" do |master|
        master.vm.provider "virtualbox" do |v|
            v.memory = 4096
            v.cpus = 2
            v.name = "k8s-master"
        end

        master.vm.hostname = "master"
        master.vm.network "private_network", ip: MASTER_NODE_IP
        master.vm.network "forwarded_port", guest: 22, host: MASTER_SSH_FORWARDED_PORT, auto_correct: true
    end

    # Provision worker nodes
    WORKER_NODE_IPS.each_with_index do |node_ip, index|
        hostname = "worker-#{'%02d' % (index + 1)}"
        forwarded_port = (MASTER_SSH_FORWARDED_PORT + index)
        config.vm.define "#{hostname}" do |worker|
            worker.vm.provider "virtualbox" do |v|
                v.memory = 2048
                v.cpus = 2
                v.name = "k8s-#{hostname}"
            end
            worker.vm.hostname = "#{hostname}"
            worker.vm.network "private_network", ip: node_ip
            worker.vm.network "forwarded_port", guest: 22, host: forwarded_port, auto_correct: true
        end
    end
end