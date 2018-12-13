# Description:
#   Kickstart file for www

# Requerements:
#   rootdisk should be /dev/sda
#   min 15Gb sized /dev/sda

## To be provided with cli:
#
# for static ip address:
#   ip=10.1.201.23::10.1.201.254:255.255.255.0:web:eth0:off nameserver=8.8.8.8 net.ifnames=0 biosdevname=0 ks=https://raw.githubusercontent.com/tenhishadow/kickstarts/master/www.ks
#
# for dhcp
#   ip=dhcp net.ifnames=0 biosdevname=0 ks=https://raw.githubusercontent.com/tenhishadow/kickstarts/master/www.ks
#
# ref:
#   ip=<client-IP-number>::<gateway-IP-number>:<netmask>:<client-hostname>:<interface>:[dhcp|on|any|none|off]

# Kickstart

## install instead of upgrade
install

## text mode
text

## do not configure X
skipx

## reboot after installation
reboot

## keyboard config
keyboard 'us'

## language
lang en_US

## selinux conf
selinux --enforcing

## disable services
services --disabled="kdump, tuned, irqbalance, NetworkManager"

## enable ssh 
firewall --enabled --ssh

## set timezone
timezone Europe/Moscow --isUtc

## use yandex repo for installation
url --url="http://mirror.yandex.ru/centos/7/os/x86_64"

## set pass config
auth --enableshadow --passalgo=sha512

## set init root password
rootpw --iscrypted $6$YAD3dXA9$sscfW.9bQMNv0llpfHcb7l.Tdx1H.vipZmpj/GrCm1GLH3es53Iai3j1iV1.K0mtLsTMZ9CDyofzmbY6hrcSy/

## setup network
network --bootproto=static --device=eth0 --gateway=192.168.0.1 --ip=192.168.0.52 --nameserver=8.8.8.8 --netmask=255.255.255.0 --ipv6=auto --activate

## clean mbr
zerombr

## clear partition table
clearpart --all --drives=sda

## Create partitions
part /boot --fstype ext2 --size=512
part pv.01 --size=1000 --grow --ondisk=sda

volgroup rootvg pv.01

logvol /        --vgname=rootvg --fstype=ext4 --size=6144 --name=root
logvol /var/log --vgname=rootvg --fstype=ext4 --size=1024 --name=log

logvol swap     --vgname=rootvg --fstype=swap --size=1024 --name=swap

## setup bootloader
bootloader --append="" --location=mbr --boot-drive=sda

## kdump
%addon com_redhat_kdump --disable
%end

## install packages
%packages
@^minimal
@core
vim
rsync
tar
yum-utils
firewalld
unzip
curl
chrony
tree
%end
