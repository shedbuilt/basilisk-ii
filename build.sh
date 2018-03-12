#!/bin/bash
cd BasiliskII/src/Unix
# Forcibly replace ancient automake files
rm config.guess config.sub
automake -a
autoreconf -fiv -I m4 &&
./configure --prefix=/usr/local \
            --enable-sdl-video \
            --enable-sdl-audio \
            --disable-vosf \
            --disable-jit-compiler \
            --without-gtk &&
make -j $SHED_NUMJOBS &&
make DESTDIR="$SHED_FAKEROOT" install
