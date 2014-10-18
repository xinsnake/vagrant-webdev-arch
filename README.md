# Introduction #

This Vagrantfile and related scripts are used to deploy an Arch Linux based web development environment.

# Quick start #

* To start your development environment, please follow these commands:
```bash
$ git clone git@github.com:xinsnake/vagrant-webdev.git
$ cd vagrant-webdev
$ vagrant up
```

* After that please add the following lines to your "hosts" file:
```
192.168.155.10      localhost.dev
192.168.155.10      pm.localhost.dev
```

* Default VirtualHost
  * localhost.dev (mapped to /vagrant/wwwroot)
  * pm.localhost.dev (mapped to /usr/share/webapps/phpMyAdmin)

* Please note:
  * Keep your internet conection on and if you have a data limit please watch out. The base box will need around 400MB
      data and the provisoning process will need around 100MB.
  * The total deploy time with 1MB/s internet connection is 15~20 minutes, assuming you have reasonable hardware
      configuration.

# VirtualBox and NFS file sharing #

You may notice the performance issue using VirtualBox and native file sharing, uncomment the ``config.vm.synced_folder``
__after__ the first "vagrant up". If you do it on the first "vagrant up", you will receive an error.

# Quick summary of the configuration #

* Latest\* Arch Linux for Apache, MariaDB, PHP
* Latest phpMyAdmin
* Latest NodeJS with grunt, gulp, bower
* Latest gem with compass, sass
* Other random tools like git, vim, wget, curl, tree...

\* "Latest" means the latest version of the package(s) available on Arch Linux

# Resources #

* If you are new to Vagrant, please checkout http://www.vagrantup.com/ for a quick start
* Arch Linux base box is based on Terry Wang's Arch Linux
    https://github.com/terrywang/vagrantboxes/blob/master/archlinux-x86_64.md
