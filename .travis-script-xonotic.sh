#!/bin/sh

os=$1

set -ex

case "$os" in
	linux32)
		makeflags='STRIP=: CC="${CC} -m32 -march=i686 -g1 -I../../../.deps/include -L../../../.deps/lib -DSUPPORTIPV6" LIB_JPEG=../../../.deps/lib/libjpeg.a LIB_CRYPTO="../../../.deps/lib/libd0_blind_id.a ../../../.deps/lib/libgmp.a" DP_LINK_ZLIB=shared DP_LINK_JPEG=dlopen DP_LINK_ODE=dlopen DP_LINK_CRYPTO=shared DP_LINK_CRYPTO_RIJNDAEL=dlopen'
		maketargets='release'
		outputs='darkplaces-glx darkplaces-sdl darkplaces-dedicated'
		;;
	linux64)
		makeflags='STRIP=: CC="${CC} -m64 -g1 -I../../../.deps/include -L../../../.deps/lib -DSUPPORTIPV6" LIB_JPEG=../../../.deps/lib/libjpeg.a LIB_CRYPTO="../../../.deps/lib/libd0_blind_id.a ../../../.deps/lib/libgmp.a" DP_LINK_ZLIB=shared DP_LINK_JPEG=dlopen DP_LINK_ODE=dlopen DP_LINK_CRYPTO=shared DP_LINK_CRYPTO_RIJNDAEL=dlopen'
		maketargets='release'
		outputs='darkplaces-glx darkplaces-sdl darkplaces-dedicated'
		;;
	win32)
		makeflags='STRIP=: DP_MAKE_TARGET=mingw UNAME=MINGW32 CC="i586-mingw32msvc-gcc -g1 -Wl,--dynamicbase -Wl,--nxcompat -I../../../.deps/include -L../../../.deps/lib -DUSE_WSPIAPI_H -DSUPPORTIPV6" WINDRES="i586-mingw32msvc-windres" SDL_CONFIG="../../../.deps/bin/sdl-config" DP_LINK_ZLIB=dlopen DP_LINK_JPEG=dlopen DP_LINK_ODE=dlopen DP_LINK_CRYPTO=dlopen DP_LINK_CRYPTO_RIJNDAEL=dlopen WIN32RELEASE=1 D3D=1'
		maketargets='release'
		outputs='darkplaces.exe darkplaces-sdl.exe darkplaces-dedicated.exe'
		;;
	win64)
		makeflags='STRIP=: DP_MAKE_TARGET=mingw UNAME=MINGW32 CC="amd64-mingw32msvc-gcc -g1 -Wl,--dynamicbase -Wl,--nxcompat -I../../../.deps/include -L../../../.deps/lib -DSUPPORTIPV6" WINDRES="amd64-mingw32msvc-windres" SDL_CONFIG="../../../.deps/bin/sdl-config" DP_LINK_ZLIB=dlopen DP_LINK_JPEG=dlopen DP_LINK_ODE=dlopen DP_LINK_CRYPTO=dlopen DP_LINK_CRYPTO_RIJNDAEL=dlopen WIN64RELEASE=1 D3D=1'
		maketargets='release'
		outputs='darkplaces.exe darkplaces-sdl.exe darkplaces-dedicated.exe'
		;;
	osx)
		makeflags='STRIP=: CC="gcc -g1 -arch i386 -arch ppc -arch x86_64 -isysroot /Developer/SDKs/MacOSX10.5.sdk -mmacosx-version-min=10.4 -I../../../.deps/include -L../../../.deps/lib -fno-reorder-blocks -DSUPPORTIPV6" DP_LINK_ZLIB=shared DP_LINK_JPEG=dlopen DP_LINK_ODE=dlopen DP_LINK_CRYPTO=dlopen DP_LINK_CRYPTO_RIJNDAEL=dlopen'
		maketargets='sv-release sdl-release'
		outputs='darkplaces-sdl darkplaces-dedicated'
		;;
esac

eval "make ${makeflags} ${maketargets}"
mkdir "output.${os}"
mv ${outputs} "output.${os}"/
