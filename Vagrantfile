#########################################################################
# Title:         Cloudbox: Vagrant | Vagrantfile                        #
# Author(s):     desimaniac                                             #
# URL:           https://github.com/cloudbox/cloudbox                   #
# --                                                                    #
#         Part of the Cloudbox project: https://cloudbox.works          #
#########################################################################
#                   GNU General Public License v3.0                     #
#########################################################################

# Variables

$TAG = "cloudbox"
$VERBOSE = false  # false, true (= 'v'), '-vv', '-vvv'

# Function

$CONFIG_FILES = <<-SCRIPT
cd /home/vagrant/cloudbox
for f in defaults/*.default; do
    base=${f##*/} base=${base%.default}
    cp -n -- "$f" "$base"
done
SCRIPT

Vagrant.configure("2") do |config|

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", 2048]
  end

  config.vm.define "ubuntu16" do |ubuntu16|
    ubuntu16.vm.box = "ubuntu/xenial64"
  end

  # config.vm.define "ubuntu18" do |ubuntu18|
  #   ubuntu18.vm.box = "ubuntu/bionic64"
  # end

  config.vm.synced_folder ".", "/vagrant", disabled: false
  config.vm.synced_folder ".", "/home/vagrant/cloudbox", disabled: false

  config.vm.provision "shell", inline: "curl -s https://cloudbox.works/scripts/dep.sh | bash"
  config.vm.provision "shell", privileged: false, inline: $CONFIG_FILES

  config.vm.provision "ansible_local", run: "always" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.config_file = "/home/vagrant/cloudbox/ansible.cfg"
    ansible.inventory_path = "/home/vagrant/cloudbox/inventories/local"
    ansible.limit = "all"
    ansible.playbook = "/home/vagrant/cloudbox/cloudbox.yml"
    ansible.become = true
    ansible.skip_tags = ['sanity_check','settings']
    ansible.extra_vars = { continuous_integration: true }
    ansible.tags = $TAG
    ansible.verbose = $VERBOSE
  end

end
