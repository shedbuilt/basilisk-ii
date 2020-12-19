#!/bin/bash
# Allow use of software SDL video surfaces
# patch -Np1 -i "${SHED_PKG_PATCH_DIR}/allow_sw_sdl_surface.patch"
cd BasiliskII/src/Unix &&
# Forcibly replace ancient automake files
rm -v config.guess config.sub || exit 1
# automake will fail due to missing Makefile.am, but will link to new config.guess and config.sub
automake --add-missing --copy
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
