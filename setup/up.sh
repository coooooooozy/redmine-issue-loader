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

cd DIR
bash setup.sh

docker-compose \
    --project-name redmine-issue-loader \
    --file $DIR/docker-compose.yml \
    --file $DIR/docker-compose.personal.yml \
    --file $DIR/docker-compose.private.yml \
    up \
    --detach \
    --build
