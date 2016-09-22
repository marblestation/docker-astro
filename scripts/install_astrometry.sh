#!/bin/bash
wget -c http://astrometry.net/downloads/astrometry.net-latest.tar.gz
tar -zxvf astrometry.net-latest.tar.gz
cd astrometry.net-*
make
#py_setup
make py
make extra
mkdir -p /opt/astrometry/
make install INSTALL_DIR=/opt/astrometry
cd ..
rm -rf astrometry.net-*
