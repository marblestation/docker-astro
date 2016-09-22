#!/bin/bash
wget -c http://www.astromatic.net/download/sextractor/sextractor-2.19.5.tar.gz
tar -zxvf sextractor-2.19.5.tar.gz
cd sextractor-2.19.5/
./configure --with-atlas-incdir=/usr/include/atlas/ --with-atlas-libdir=/usr/lib/atlas-base/atlas/
make
make install
cd ..
rm -rf sextractor-2.19.5*

wget -c http://www.astromatic.net/download/psfex/psfex-3.17.1.tar.gz
tar -zxvf psfex-3.17.1.tar.gz
cd psfex-3.17.1/
./configure --with-atlas-incdir=/usr/include/atlas/ --with-atlas-libdir=/usr/lib/atlas-base/atlas/
make
make install
cd ..
rm -rf psfex-3.17.1*

wget -c http://www.astromatic.net/download/swarp/swarp-2.38.0.tar.gz
tar -zxvf swarp-2.38.0.tar.gz
cd swarp-2.38.0
./configure
make
make install
cd ..
rm -rf swarp-2.38.0*

wget -c http://www.astromatic.net/download/missfits/missfits-2.8.0.tar.gz
tar -zxvf missfits-2.8.0.tar.gz
cd missfits-2.8.0
./configure
make
make install
cd ..
rm -rf missfits-2.8.0*
