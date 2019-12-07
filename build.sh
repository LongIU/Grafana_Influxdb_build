#!/bin/bash


check_SELinux=$(cat /etc/selinux/config | grep "^SELINUX=" |awk -F\= '{print $2}')

[[ ${check_SELinux} != "disabled" ]] && echo ${1} |sudo -S sed -i '/^SELINUX=/c\SELINUX=disabled' /etc/selinux/config


echo ${1} |sudo -S yum install -y git
