FROM ubuntu:17.04

RUN apt-get update && apt-get install -y mingw-w64 git cmake mingw-w64-tools python3 python3-docutils python3-pip rpm2cpio nano libfile-mimeinfo-perl wget cpio locales wine-stable curl zip wget && \
update-alternatives --set x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-posix && \
update-alternatives --set x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix



RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US:en 
ENV LC_ALL en_US.UTF-8
ENV PATH=/work/inst/bin:$PATH
ENV SHELL=/bin/bash

#RUN LC_CTYPE="en_US.UTF-8" pip3 install crossroad

ADD crossroad-utf8.patch /work/crossroad-utf8.patch
ADD crossroad-0.7 /work/crossroad-0.7

RUN mkdir -p /work && cp -a /work/crossroad-0.7 /work/crossroad-0.7-build && ls /work/crossroad-0.7-build && \
cd /work/crossroad-0.7-build && python3 ./setup.py install --prefix=/work/inst
#RUN echo "" >> /work/inst/share/crossroad/scripts/cmake/toolchain-w64.cmake
#RUN echo "SET(PKG_CONFIG_EXECUTABLE i686-w64-mingw32-pkg-config)" >> #/work/inst/share/crossroad/scripts/cmake/toolchain-w64.cmake


#RUN cat /work/dep-install.sh
#RUN echo "shell: $SHELL"
#RUN crossroad w64 w64-build
ADD dep-install.sh /work/dep-install.sh
RUN crossroad w64 w64-build --run=/work/dep-install.sh 
#RUN cat /work/dep-build.sh
#RUN cat /work/ilmbase-mingw.patch
ADD ilmbase-mingw.patch libiptcdata-mingw.patch openexr-mingw.patch /work/
ADD dep-build.sh /work/dep-build.sh
RUN crossroad w64 w64-build --run=/work/dep-build.sh
#ADD phf-build.sh /work/phf-build.sh
#RUN crossroad w64 w64-build --run=/work/phf-build.sh
#RUN /bin/bash --help
#RUN /bin/bash --rcfile /work/inst/share/crossroad/scripts/shells/bash/bashrc.w64 -ci "echo ciao"
#RUN bash /work/dep-install.sh
#RUN cat /work/inst/share/crossroad/scripts/shells/bash/bashrc.w64
