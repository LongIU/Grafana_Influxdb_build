#!/bin/bash

basedir=$(cd `dirname $0`;pwd)

mkdir -p data
ID=$(id -u)

sudo docker stop grafana
sudo docker rm grafana

#sudo docker run -d --name grafana -p 3000:3000 squirrel0629/grafana grafana

sudo docker run \
            -d --name grafana -p 3000:3000 \
            -e "GF_SERVER_ROOT_URL=http://grafana.long_docker.com" \
            -e "GF_SECURITY_ADMIN_PASSWORD=qwer1234" \
            --user ${ID} --volume "${basedir}/data:/var/lib/grafana" \
            -v "${basedir}/grafana/grafana.ini:/etc/grafana/grafana.ini:ro" \
            squirrel0629/grafana grafana
