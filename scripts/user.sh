#!/bin/bash

# Root User Script Config
ROOT_PW='RootChangeMe!'
ROOT_SSH=''

# Otto User Script Config
OTTO_PW='OttoChangeMe!'
OTTO_SSH=''

# Root Configuration
mkdir -p /root/.ssh/
echo $ROOT_SSH >> /root/.ssh/authorized_keys
echo root:$ROOT_PW | /usr/sbin/chpasswd

# Otto Configuration
mkdir -p /home/otto/.ssh/
chown otto:otto /home/otto/.ssh
echo $OTTO_SSH >> /home/otto/.ssh/authorized_keys
chown otto:otto /home/otto/.ssh/authorized_keys
echo otto:$OTTO_PW | /usr/sbin/chpasswd
rm /home/otto/linux.iso

# System Config
apt-get -y -qq update

# OpenSSH Config
mkdir /etc/ssh/old_keys
mv /etc/ssh/ssh_host_* /etc/ssh/old_keys
dpkg-reconfigure openssh-server
sed -i 's/*PermitRootLogin*/PermitRootLogin\ without-password/g' /etc/ssh/sshd_config
