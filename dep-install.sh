#! /bin/bash

echo "Installing packages"
crossroad install libtiff5 libtiff-devel libpng16-16 libpng-devel libjpeg8 libjpeg8-devel libcairo2 libcairo-gobject2 gdk-pixbuf-loader-rsvg librsvg-2-2 cairo-devel libgtkmm-2_4-1 gtkmm2-devel glib2-tools gsettings-desktop-schemas gsettings-desktop-schemas-devel libexpat1 libexpat-devel win_iconv win_iconv-devel liblcms2-2 liblcms2-devel libxml2-2 libxml2-devel libxml2-tools libfftw3-3 fftw3-devel libexif12 libexif-devel libepoxy-devel libepoxy0
# gtkmm3 gtkmm3-devel
#crossroad install librsvg-2-2
wine $CROSSROAD_PREFIX/bin/glib-compile-schemas.exe $CROSSROAD_PREFIX/share/glib-2.0/schemas
