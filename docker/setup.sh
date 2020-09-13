#!/bin/bash -Ceu

#http://stackoverflow.com/a/246128/5209556
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

cd $DIR

if [ ! -e ~/.gitconfig ]; then
  touch ~/.gitconfig
fi

git update-index --skip-worktree docker-compose.personal.yml

cat << EOF > docker-compose.personal.yml
## This file was generated by setup.sh.
version: '3'
services:
  dev:
    build:
      args:
        - uid=$(id -u)
        - gid=$(id -g)
        - lang=${LANG}
        - timezone=$(timedatectl show --property=Timezone --value)
EOF
