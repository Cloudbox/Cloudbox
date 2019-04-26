$script = <<-SCRIPT
cd ~/Cloudbox
for f in defaults/*.default; do base=${f##*/} base=${base%.default}; cp -- "$f" "$base"; done
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/home/vagrant/Cloudbox", disabled: false
  config.vm.synced_folder ".", "/vagrant", disabled: false
  config.vm.provision "shell", path: "https://cloudbox.works/scripts/dep.sh"
  config.vm.provision "shell", privileged: false, inline: $script
  config.vm.provision "ansible_local" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.verbose = "y"
    ansible.playbook = "/home/vagrant/Cloudbox/cloudbox.yml"
    ansible.tags = "cloudbox"
    ansible.limit = "all"
    ansible.become = true
  end
  config.vm.define "ubuntu18" do |ubuntu18|
    ubuntu18.vm.box = "generic/ubuntu1804"
  end
  # config.vm.define "ubuntu16" do |ubuntu16|
  #   ubuntu16.vm.box = "generic/ubuntu1604"
  # end
end
