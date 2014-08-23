#!/bin/sh

set -ex

if [ "`uname`" = 'Linux' ]; then
	sudo apt-get update -qq
	# linux64 parts.
	sudo apt-get install -y libxpm-dev
	# linux32 parts.
	sudo apt-get install -y libc6-dev-i386
	# win64/win32 parts.
	sudo apt-get install -y mingw-w64 mingw32- mingw32-binutils-
fi

git archive --format=tar --remote=git://de.git.xonotic.org/xonotic/xonotic.git --prefix=.deps/ master:misc/builddeps | tar xvf -
for X in .deps/*; do
	rsync --remove-source-files -vaSHP -L "$X"/*/ "$X"/ || true
done
