#!/bin/sh

usage() {
  cat <<EOT

  Usage: `basename $0` <URL> <IP>

EOT
  exit 1
}

[ $# -ne 2 ] && usage

URI=$1
IP=$2

CURDIR=`pwd`
cd ~/cloudfoundry/.deployments/devbox/config

# Editing deployment files
FILES=`ls -1 *.yml`
sed -i.bak "s/api.vcap.me/$URI/;s/127.0.0.1/$IP/;s/localhost:4222/$IP:4222/" $FILES

# faking /etc/hosts to be able to ping $URI locally in the ec2 environment
sudo sh -c "echo \"$IP $URI\" >> /etc/hosts"

cd $CURDIR

