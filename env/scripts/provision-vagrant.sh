#!/bin/bash

CFG=/vagrant/env/config

echo
echo '== BEGIN script running as VAGRANT =='
echo

#
# Configure .bashrc
#
echo
echo '== Configuring .bashrc =='
echo
mv /home/vagrant/.bashrc /home/vagrant/.bashrc.vagrantbkp
cp $CFG/home/vagrant/bashrc /home/vagrant/.bashrc
chmod 644 /home/vagrant/.bashrc

#
# Configure Ruby Gems
#
echo
echo '== Configuring Ruby Gems =='
echo
gem update
gem install compass