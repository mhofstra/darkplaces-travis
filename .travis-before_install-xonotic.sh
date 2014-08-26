#!/bin/sh

set -ex

if [ "`uname`" = 'Linux' ]; then
  sudo apt-get update -qq
fi

for os in "$@"; do
  case "$os" in
    linux32)
      sudo apt-get install -y libc6-dev-i386 libxpm-dev:i386 libsdl1.2-dev:i386 libxxf86vm-dev:i386 libglu1-mesa-dev:i386 libxext-dev:i386 libglu1-mesa:i386 libgl1-mesa-dev:i386 libgl1-mesa-glx:i386 libglapi-mesa:i386
      ;;
    linux64)
      sudo apt-get install -y libxpm-dev libsdl1.2-dev libxxf86vm-dev
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
done

git archive --format=tar --remote=git://de.git.xonotic.org/xonotic/xonotic.git --prefix=.deps/ master:misc/builddeps | tar xvf -
for X in .deps/*; do
  rsync --remove-source-files -vaSHP -L "$X"/*/ "$X"/ || true
done
