#!/bin/bash

CFG=/vagrant/env/config

echo
echo '== BEGIN script running as ROOT =='
echo

#
# Configure host-only connection
#
echo
echo '== Configuring network =='
echo
cp $CFG/etc/conf.d/net-conf-enp0s8 /etc/conf.d/
cp $CFG/etc/systemd/system/network@.service /etc/systemd/system/
cp $CFG/usr/local/bin/net-* /usr/local/bin/
chmod 554 /usr/local/bin/net-{up,down}.sh
systemctl enable network@enp0s8
systemctl start network@enp0s8

#
# Install necessary programs
#
echo
echo '== Installing programs =='
echo
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.vagrantbkp
cp /vagrant/env/config/etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist
chmod 644 /etc/pacman.d/mirrorlist
pacman -Syyu --noconfirm
pacman -S --noconfirm apache mariadb mariadb-clients php php-fpm php-gd php-mcrypt php-sqlite php-geoip phpmyadmin xdebug nodejs npm nfs-utils

#
# NFS file system
#
echo
echo '== Setting up NFS =='
echo
systemctl start nfs-client.target
systemctl enable nfs-client.target
systemctl start rpcbind.service
systemctl enable rpcbind.service

#
# Configure MySQL
#
echo
echo '== Setting up MySQL =='
echo
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl enable mysqld
systemctl start mysqld

expect < /vagrant/env/scripts/mysql_secure.exp

systemctl restart mysqld

#
# Configure php-fpm
#
echo
echo '== Setting up php-fpm =='
echo
systemctl enable php-fpm
systemctl start php-fpm

mv /etc/php/php.ini /etc/php/php.ini.vagrantbkp
cp $CFG/etc/php/php.ini /etc/php/php.ini
chmod 644 /etc/php/php.ini

mv /etc/php/php-fpm.conf /etc/php/php-fpm.conf.vagrantbkp
cp $CFG/etc/php/php-fpm.conf /etc/php/php-fpm.conf
chmod 644 /etc/php/php-fpm.conf

mv /etc/php/conf.d/xdebug.ini /etc/php/conf.d/xdebug.ini.vagrantbkp
cp $CFG/etc/php/conf.d/xdebug.ini /etc/php/conf.d/xdebug.ini
chmod 644 /etc/php/conf.d/xdebug.ini

systemctl restart php-fpm

#
# Configure Apache
#
echo
echo '== Setting up Apache =='
echo
systemctl enable httpd
systemctl start httpd

mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.vagrantbkp
cp $CFG/etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf
chmod 644 /etc/httpd/conf/httpd.conf

mv /etc/httpd/conf/extra/httpd-vhosts.conf /etc/httpd/conf/extra/httpd-vhosts.conf.vagrantbkp
cp $CFG/etc/httpd/conf/extra/httpd-vhosts.conf /etc/httpd/conf/extra/httpd-vhosts.conf
chmod 644 /etc/httpd/conf/extra/httpd-vhosts.conf

mv /etc/httpd/conf/extra/httpd-ssl.conf /etc/httpd/conf/extra/httpd-ssl.conf.vagrantbkp
cp $CFG/etc/httpd/conf/extra/httpd-ssl.conf /etc/httpd/conf/extra/httpd-ssl.conf
chmod 644 /etc/httpd/conf/extra/httpd-ssl.conf

systemctl restart httpd

#
# Configure phpMyAdmin
#
echo
echo '== Configuring phpMyAdmin =='
echo
mysql -u root -ppassword < /usr/share/webapps/phpMyAdmin/sql/create_tables.sql

mv /etc/webapps/phpmyadmin/config.inc.php /etc/webapps/phpmyadmin/config.inc.php.vagrantbkp
cp $CFG/etc/webapps/phpmyadmin/config.inc.php /etc/webapps/phpmyadmin/config.inc.php
chmod 644 /etc/webapps/phpmyadmin/config.inc.php

#
# Configure node
#
echo
echo '== Configuring NodeJS =='
echo
npm update -g
npm install -g bower grunt-cli gulp
chown -R vagrant:vagrant /usr/lib/node_modules
