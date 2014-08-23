#!/bin/sh

set -ex

if [ "`uname`" = 'Linux' ]; then
	sudo apt-get update -qq
	sudo apt-get install -y libc6-dev-i386 zlib1g-dev:i386 libxpm-dev
	sudo apt-get install -y mingw-w64 gcc-mingw-w64 g++-mingw-w64 g++-mingw-w64-i686 g++-mingw-w64-x86-64 gcc-mingw-w64-i686 gcc-mingw-w64-x86-64 binutils-mingw-w64-i686 binutils-mingw-w64-x86-64
fi

git archive --format=tar --remote=git://de.git.xonotic.org/xonotic/xonotic.git --prefix=.deps/ master:misc/builddeps | tar xvf -
for X in .deps/*; do
	rsync --remove-source-files -vaSHP -L "$X"/*/ "$X"/ || true
done
