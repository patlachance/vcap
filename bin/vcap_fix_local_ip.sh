#!/bin/sh

usage() {
  cat <<EOT

  Usage: `basename $0` <confdir>

EOT
  exit 1
}

error() {
   echo "Error"
   exit 2
}

[ $# -ne 1 ] && usage
CONFDIR=$1

[ ! -f $CONFDIR/router.yml ] && error confdir

HOSTIP=`ifconfig eth0 | grep 'inet addr' | awk '{print $2}' | cut -d: -f2`
CONFIP=`grep mbus $CONFDIR/router.yml  | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}'`

CURDIR=`pwd`
cd $CONFDIR

# Editing deployment files
FILES=`ls -1 *.yml`
sed -i.bak "s/$CONFIP/$HOSTIP/" $FILES

cd $CURDIR
