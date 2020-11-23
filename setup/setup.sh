#!/bin/bash -Ceu

#http://stackoverflow.com/a/246128/5209556
#https://stackoverflow.com/questions/35006457
SOURCE="${BASH_SOURCE[0]:-$0}"
while [ -h "$SOURCE" ]; do
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

cd $DIR

cat << EOF >| docker-compose.personal.yml
# This file was generated automatically by setup.sh.
# Do not change this file as it will be overwritten
# by setup.sh when building Docker Container.
# If you want to add private settings, you make
# "docker-compose.private.original.yml".
version: '3'
services:
  dev:
EOF

if [ -e docker-compose.private.original.yml ]; then
    cp --force \
        docker-compose.private.original.yml \
        docker-compose.private.yml
elif [ ! -e docker-compose.private.yml ]; then
    cp --force \
        docker-compose.personal.yml \
        docker-compose.private.yml
fi

cat << EOF >> docker-compose.personal.yml
    build:
      args:
        - uid=$(id -u)
        - gid=$(id -g)
        - lang=${LANG}
EOF