#!/bin/bash
# stop on errors
set -e
FROM=2022.1.x
BRANCH=experimental
FIRMWAREPATH=/var/www/firmware/download

if ! command -v ecdsasign &> /dev/null
then
	echo "Please install ecdsautils"
	exit
fi

wget -N https://raw.githubusercontent.com/freifunk-gluon/gluon/master/contrib/sign.sh > /dev/null 2>&1 || (echo "Check your network" && false)
chmod 744 sign.sh
mkdir -p from-${FROM}
scp ffac@build.freifunk-aachen.de:${FIRMWAREPATH}/from-${FROM}/sysupgrade/${BRANCH}.manifest from-${FROM}/${BRANCH}.manifest
./sign.sh  ~/.gluon-secret-key from-${FROM}/${BRANCH}.manifest
scp from-${FROM}/${BRANCH}.manifest ffac@build.freifunk-aachen.de:$FIRMWAREPATH/from-${FROM}/sysupgrade/${BRANCH}.manifest
