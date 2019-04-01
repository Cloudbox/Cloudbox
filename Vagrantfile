Vagrant.configure("2") do |config|
  config.vm.provision "ansible" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.verbose = "y"
    ansible.playbook = "vagrant.yml"
    ansible.limit = "all"
    ansible.become = true
  end

  config.vm.define "ubuntu18" do |ubuntu18|
    ubuntu18.vm.box = "geerlingguy/ubuntu1804"
  end
end
