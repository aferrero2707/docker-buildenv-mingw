FROM ubuntu:17.10

RUN apt-get update && apt-get install -y mingw-w64 git cmake mingw-w64-tools python3 python3-docutils python3-pip rpm2cpio nano libfile-mimeinfo-perl wget cpio locales wine-stable curl zip wget libglib2.0-dev libxml2-utils librsvg2-dev && \
ln -s /usr/bin/python3 /usr/bin/python && \
update-alternatives --set x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-posix && \
update-alternatives --set x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix



RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US:en 
ENV LC_ALL en_US.UTF-8
ENV PATH=/work/inst/bin:/usr/local/bin:$PATH
ENV SHELL=/bin/bash

#RUN LC_CTYPE="en_US.UTF-8" pip3 install crossroad

ADD crossroad-utf8.patch /work/crossroad-utf8.patch
ADD crossroad-0.7 /work/crossroad-0.7

RUN mkdir -p /work && cp -a /work/crossroad-0.7 /work/crossroad-0.7-build && ls /work/crossroad-0.7-build && \
cd /work/crossroad-0.7-build && python3 ./setup.py install --prefix=/usr/local
#RUN echo "" >> /work/inst/share/crossroad/scripts/cmake/toolchain-w64.cmake
#RUN echo "SET(PKG_CONFIG_EXECUTABLE i686-w64-mingw32-pkg-config)" >> #/work/inst/share/crossroad/scripts/cmake/toolchain-w64.cmake


#RUN cat /work/dep-install.sh
#RUN echo "shell: $SHELL"
#RUN crossroad w64 w64-build
ADD dep-install.sh /work/dep-install.sh

# stop here

RUN crossroad w64 w64-build --run=/work/dep-install.sh 
ADD ilmbase-mingw.patch libiptcdata-mingw.patch openexr-mingw.patch gtk+-3-disable-demos.patch /work/
ADD dep-build.sh dep-build1.sh /work/
RUN crossroad w64 w64-build --run=/work/dep-build1.sh
ADD dep-build2.sh /work/dep-build2.sh
RUN crossroad w64 w64-build --run=/work/dep-build2.sh
ADD dep-build3.sh /work/dep-build3.sh
RUN crossroad w64 w64-build --run=/work/dep-build3.sh
ADD dep-build.sh /work/
RUN crossroad w64 w64-build --run=/work/dep-build.sh

#ADD dep-install2.sh /work/dep-install2.sh
#RUN crossroad w64 w64-build --run=/work/dep-install2.sh 