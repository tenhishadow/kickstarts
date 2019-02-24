# Kickstart file for Centos 7

# install instead of upgrade
install

# text mode
text

# do not configure X
skipx

# reboot after installation
reboot

# keyboard config
keyboard 'us'

# language
lang en_US

# selinux conf
selinux --enforcing

# enable ssh
firewall --enabled --ssh

# set timezone
timezone Europe/Moscow --isUtc

# use yandex repo for installation
url --url="http://mirror.centos.org/altarch/7/os/i386/"

# set pass config
auth --enableshadow --passalgo=sha512

# set init root password
rootpw --iscrypted $6$6t0jSWR9$VDoGcI78ARu5f3wQW8uqHGHv.dEi25dyK/OZ1nmIaZ8Vg5/0JRUdnZes70KUoiVJMgCMQzQeD5wOFfb9Fm5eT0

# setup network
network  --bootproto=dhcp

zerombr
clearpart --all --drives=sda

# Create partitions
part /boot --fstype ext2 --size=512
part pv.01 --size=100 --grow --ondisk=sda
volgroup rootvg pv.01
logvol / --vgname=rootvg --fstype=ext4 --size=4096 --name=root
logvol swap --vgname=rootvg --fstype=swap --size=256 --name=swap

# set bootloader
bootloader --append="" --location=mbr --boot-drive=sda

%packages
@^minimal
@core
vim
%end
