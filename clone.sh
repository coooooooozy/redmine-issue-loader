#!/bin/bash -e

#http://stackoverflow.com/a/246128/5209556
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

cd $DIR

if [ ! -e .git ]; then
  git clone \
    https://github.com/coooooooozy/redmine-issue-loader.git \
    tmp \
    --no-checkout
  mv --update tmp/.git .
  rm -rf tmp
  git reset \
    --hard \
    --recurse-submodules \
    origin/master
fi
