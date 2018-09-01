#! /bin/bash
arch=$1

env

echo "Compiling dependencies"

(rm -rf /work/libiptcdata-1* && cd /work && \
wget https://sourceforge.net/projects/libiptcdata/files/libiptcdata/1.0.4/libiptcdata-1.0.4.tar.gz && \
tar xzvf libiptcdata-1.0.4.tar.gz && cd libiptcdata-1.0.4 && \
patch -p1 < /work/libiptcdata-mingw.patch && \
crossroad configure && make -j 2 && make install && \
cd .. && rm -rf /work/libiptcdata-1*) || exit 1

(rm -rf /work/ilmbase-2* && cd /work && \
wget http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.1.tar.gz && \
tar xzvf ilmbase-2.2.1.tar.gz && cd ilmbase-2.2.1 && \
patch -p1 < /work/ilmbase-mingw.patch && \
patch -p0 < /work/ilmbase-limits.patch && \
mkdir -p build && cd build && \
crossroad cmake .. && make VERBOSE=1 && make install) || exit 0

#(rm -rf /work/ilmbase* && cp -a /sources/ilmbase-2.2.0 /work && \
#cd /work/ilmbase-2.2.0 && mkdir -p build && cd build && \
#crossroad cmake .. && make VERBOSE=1 && make install) || exit 1

#exit 0

(rm -rf /work/openexr-2* && cd /work && \
wget http://download.savannah.nongnu.org/releases/openexr/openexr-2.2.1.tar.gz && \
tar xzvf openexr-2.2.1.tar.gz && cd openexr-2.2.1 && \
patch -p1 < /work/openexr-mingw.patch && \
mkdir -p build && cd build && \
crossroad cmake -DILMBASE_PACKAGE_PREFIX=$CROSSROAD_PREFIX .. && make VERBOSE=1 && make install && \
cd .. && rm -rf /work/ilmbase-2* && rm -rf /work/openexr-2*) || exit 1

#(rm -rf /work/openexr* && cp -a /sources/openexr-2.2.0 /work && \
#cd /work/openexr-2.2.0 && mkdir -p build && cd build && \
#crossroad cmake -DILMBASE_PACKAGE_PREFIX=$HOME/.local/share/crossroad/roads/w64/w64-build .. && make VERBOSE=1 && make install) || exit 1

#exit 0

# PugiXML
(cd /work && rm -rf pugixml* && git clone https://github.com/zeux/pugixml.git && cd pugixml && \
mkdir -p build && cd build && \
crossroad cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DBUILD_PKGCONFIG=ON .. && \
make && make install) || exit 1

(cd /work && rm -rf vips-* && \
wget https://github.com/jcupitt/libvips/releases/download/v8.5.6/vips-8.5.6.tar.gz && \
tar xzvf vips-8.5.6.tar.gz && cd vips-8.5.6 && \
crossroad configure --disable-gtk-doc --disable-gtk-doc-html --disable-introspection --enable-debug=no --without-python --without-magick --without-libwebp  --without-orc && \
make -j 3 && make install && cd .. && rm -rf vips-*) || exit 1;
