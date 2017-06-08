# -*- mode: ruby -*-
# vi: set ft=ruby :

# NestedBird  Copyright (C) 2016-2017  Michael Haddon
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License version 3
# as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Vagrant box settings
  config.vm.box = "puppetlabs/centos-7.2-64-puppet-enterprise"
  config.vm.box_version = "1.0.1"

  # Configure virtual box
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of memory on the VM:
    vb.memory = "4096"
  end

  # Configure ports
  config.vm.network "forwarded_port", guest: 80, host: 18080
  config.vm.network "forwarded_port", guest: 3306, host: 13306

  # Provisioners
  config.vm.provision "shell", inline: <<-SHELL
    echo '\n\tNestedBird  Copyright (C) 2016-2017  Michael Haddon\n\tThis program comes with ABSOLUTELY NO WARRANTY.\n\tThis is free software, and you are welcome to redistribute it\n\tunder certain conditions.\n\tView LICENSE for more information.\n\t'
  SHELL

  config.vm.provision "puppet" do |puppet|
    puppet.module_path = "modules"
    puppet.options = "--verbose --debug"
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo '\n\tFinished\n\tNavigate to http://www.sound.dev:18080/\n\tIt may take a while to finish loading\n\t'
  SHELL
end
