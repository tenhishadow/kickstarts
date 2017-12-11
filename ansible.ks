# Kickstart file for Centos 7
# Version 0.1


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
url --url="http://mirror.yandex.ru/centos/7/os/x86_64"

# set pass config
auth --enableshadow --passalgo=sha512

# set init root password
rootpw --iscrypted $6$P30TmnxG$MQsfjTSX0.ZrGLcaNckfFC7zHuwoypQnOEb9T1FFD2uiEQXgFZWkPMSwBfIDTSOlFDejN6gupHg6XvnD8awZL1

# setup network
network  --bootproto=dhcp

zerombr
clearpart --all --drives=vda

# Create partitions
part /boot --fstype ext2 --size=256
part pv.01 --size=100 --grow --ondisk=vda
volgroup rootvg pv.01
logvol / --vgname=rootvg --fstype=ext4 --size=4096 --name=root
logvol swap --vgname=rootvg --fstype=swap --size=128 --name=swap

# set bootloader
bootloader --append="" --location=mbr --boot-drive=vda

%packages
@^minimal
@core
vim
%end
