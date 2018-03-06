#! /bin/bash
echo "Compiling dependencies"


# PugiXML
(mkdir -p /work && cd /work && rm -rf gtkmm-3.* && \
wget https://ftp.gnome.org/pub/gnome/sources/gtkmm/3.22/gtkmm-3.22.2.tar.xz && \
tar xJvf gtkmm-3.22.2.tar.xz && cd gtkmm-3.22.2 && \
crossroad configure && make -j 2 && make install) || exit 1
rm -rf /work/gtkmm-3.*