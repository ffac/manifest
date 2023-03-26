#!/bin/bash
# stop on errors
set -e
FROM=2022.1.x
BRANCH=experimental

scp ffac@community-build.freifunk-aachen.de:~/manifest/from-${FROM}/${BRANCH}.manifest from-${FROM}/${BRANCH}.manifest
sign.sh  ~/.gluon-secret-key from-${FROM}/${BRANCH}.manifest
scp from-${FROM}/${BRANCH}.manifest ffac@community-build.freifunk-aachen.de:~/manifest/from-${FROM}/${BRANCH}.manifest