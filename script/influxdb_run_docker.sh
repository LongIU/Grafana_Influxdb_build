#!/bin/bash

PWD=$(cd `dirname $0`;pwd)

mkdir -p data
mkdir -p influxdb
ID=$(id -u)

sudo docker stop influxdb
sudo docker rm influxdb


sudo docker run -d --name=influxdb -p 8086:8086 \
      -v ${PWD}/influxdb/influxdb.conf:/etc/influxdb/influxdb.conf:ro \
      -v ${PWD}/data/influxdb:/var/lib/influxdb \
      squirrel0629/influxdb -config /etc/influxdb/influxdb.conf
