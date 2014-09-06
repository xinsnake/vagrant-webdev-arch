
$script = <<'SCRIPT'

  # begin
  startAt=$(date +"%s")

  # run root script
  sudo -i /vagrant/env/scripts/provision-root.sh
  
  # run vagrant script
  sudo -u vagrant -i /vagrant/env/scripts/provision-vagrant.sh
  
  # TODO: run check command
  # sudo -i /vagrant/env/scripts/provision-check.sh

  # echo configuration
  endAt=$(date +"%s")
  diff=$(($endAt-$startAt))

  echo 
  echo "======================================================================="
  echo '                    _                       _                       '
  echo '                   (_)                     | |                      '
  echo '              __  ___ _ __  ___ _ __   __ _| | _____                '
  echo '              \ \/ / | '"'"'_ \/ __| '"'"'_ \ / _` | |/ / _ \       '
  echo '               >  <| | | | \__ \ | | | (_| |   <  __/               '
  echo '              /_/\_\_|_| |_|___/_| |_|\__,_|_|\_\___|               '
  echo 
  echo "Provisioning finished, just few things you need to do before you start!"
  echo
  echo "  1. Please add the following lines to your hosts file:"
  echo "      192.168.155.10    localhost.dev"
  echo "      192.168.155.10    pm.localhost.dev"
  echo
  echo "  2. Try to visit http://localhost.dev/ and you should see phpinfo()"
  echo
  echo "  3. Try to visit http://pm.localhost.dev/ and you should see phpMyAdmin"
  echo
  echo "Provisioning took $(($diff / 60)) minutes and $(($diff % 60)) seconds"
  echo
  echo "======================================================================="
  echo 

SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "terrywang/arch"
  config.vm.box_url = "http://cloud.terry.im/vagrant/archlinux-x86_64.box"
  config.vm.provision "shell", inline: $script, run: "always"
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.network "private_network", ip: "192.168.155.10", auto_config:false

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--groups", "/xinsnake"]
  end

end
