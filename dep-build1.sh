#! /bin/bash
arch=$1

env

echo "Compiling dependencies"

(mkdir -p /work && cd /work && rm -rf gtk+3.* && \
wget https://ftp.gnome.org/pub/gnome/sources/gtk+/3.22/gtk+-3.22.26.tar.xz && \
tar xJvf gtk+-3.22.26.tar.xz && cd gtk+-3.22.26 && \
patch -p1 < /work/gtk+-3-disable-demos.patch && \
crossroad configure && make -j 2 && make install) || exit 1
rm -rf /work/gtk+3.*
