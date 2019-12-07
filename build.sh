#!/bin/bash

#確認SELINUX有沒有disabled
check_SELinux=$(cat /etc/selinux/config | grep "^SELINUX=" |awk -F\= '{print $2}')

[[ ${check_SELinux} != "disabled" ]] && echo ${1} |sudo -S sed -i '/^SELINUX=/c\SELINUX=disabled' /etc/selinux/config

#安裝套件
echo ${1} |sudo -S yum install -y git vim telnet

#更新套件
echo ${1} |sudo -S yum -y update

#安裝docker
echo ${1} |sudo -S yum install -y docker

#預設開機docker服務啟動
echo ${1} |sudo -S systemctl enable docker

#啟動docker
echo ${1} |sudo -S systemctl start docker


#建置influx
mkdir -p influxdb/influxdb
cp conf/influxdb.conf influxdb/influxdb/
cp script/influxdb_run_docker.sh influxdb/influxdb_run_docker.sh
cd influxdb;sh influxdb_run_docker.sh
cd ..

#建置grafana
mkdir -p grafana/grafana
cp conf/grafana.ini grafana/grafana/grafana.ini
cp script/grafana_run_docker.sh grafana/grafana_run_docker.sh
cd grafana;sh grafana_run_docker.sh
cd ..


