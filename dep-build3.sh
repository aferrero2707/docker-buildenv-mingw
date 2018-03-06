#! /bin/bash
echo "Compiling dependencies"


# LensFun
(mkdir -p /work && cd /work && rm -rf lensfun-0.3.* && \
wget https://sourceforge.net/projects/lensfun/files/0.3.2/lensfun-0.3.2.tar.gz &&
tar xzvf lensfun-0.3.2.tar.gz && cd lensfun-0.3.2 && mkdir build && cd build && \
crossroad cmake .. && make -j 2 && make install) || exit 1
rm -rf /work/lensfun-0.3.*