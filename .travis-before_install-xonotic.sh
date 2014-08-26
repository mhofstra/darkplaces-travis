#!/bin/sh

set -ex

if [ "`uname`" = 'Linux' ]; then
  sudo apt-get update -qq
fi

for os in "$@"; do
  case "$os" in
    linux32)
      # Prepare an i386 chroot.
      chroot="$PWD"/buildroot.i386
      mkdir -p "$chroot"/mnt
      sudo apt-get install -y debootstrap
      sudo i386 debootstrap --arch=i386 precise "$chroot"
      sudo mount --rbind "$PWD" "$chroot"/mnt
      sudo i386 chroot "$chroot" apt-get install -y build-essential
      # Now install our dependencies.
      sudo i386 chroot "$chroot" apt-get install -y libxpm-dev libsdl1.2-dev libxxf86vm-dev
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
