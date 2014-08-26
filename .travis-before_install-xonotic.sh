#!/bin/sh

set -ex

if [ "`uname`" = 'Linux' ]; then
  sudo apt-get update -qq
fi

case "$1" in
  linux32)
    sudo apt-get install -y libc6-dev-i386
    ;;
  linux64)
    sudo apt-get install -y libxpm-dev libsdl2-dev
    ;;
  win32)
    sudo apt-get install -y mingw-w64 mingw32- mingw32-binutils-
    ;;
  win64)
    sudo apt-get install -y mingw-w64 mingw32- mingw32-binutils-
    ;;
  osx)
    ;;
esac

if ! [ -d .deps ]; then
  git archive --format=tar --remote=git://de.git.xonotic.org/xonotic/xonotic.git --prefix=.deps/ master:misc/builddeps | tar xvf -
  for X in .deps/*; do
    rsync --remove-source-files -vaSHP -L "$X"/*/ "$X"/ || true
  done
fi
