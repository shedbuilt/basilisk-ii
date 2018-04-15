#!/bin/bash
# Allow use of software SDL video surfaces
patch -Np1 -i "${SHED_PKG_PATCH_DIR}/allow_sw_sdl_surface.patch"
cd BasiliskII/src/Unix
# Forcibly replace ancient automake files
rm config.guess config.sub
automake -a
autoreconf -fiv -I m4 &&
./configure --prefix=/usr/local \
            --enable-sdl-video \
            --enable-sdl-audio \
            --enable-addressing=banks \
            --disable-vosf \
            --disable-jit-compiler \
            --without-mon \
            --without-esd \
            --without-gtk \
            --without-x &&
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install
