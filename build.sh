#!/bin/bash
# Fix OOM crash on AArch64
patch -Np1 -i "${SHED_PKG_PATCH_DIR}/a306262-aarch64-oom.patch" &&
# Forcibly replace ancient automake files
cd BasiliskII/src/Unix &&
# automake will fail due to missing Makefile.am, but will create new config.guess and config.sub files
automake --add-missing --force-missing --copy
# Generate remaining required automake files
NO_CONFIGURE=1 ./autogen.sh &&
./configure --prefix=/usr/local \
            --enable-sdl-video \
            --enable-sdl-audio \
            --with-bincue \
            --enable-addressing=banks \
            --disable-vosf \
            --disable-jit-compiler \
            --without-mon \
            --without-esd \
            --without-gtk \
            --without-x &&
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install
