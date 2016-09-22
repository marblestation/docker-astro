#!/bin/bash
wget http://ds9.si.edu/archive/linux64/ds9.linux64.7.2.tar.gz
tar -zxvf ds9.linux64.7.2.tar.gz
rm ds9.linux64.7.2.tar.gz
mv ds9 /usr/local/bin/

wget -c ftp://ftp.eso.org/pub/qfits/qfits-6.2.0.tar.gz
tar -zxvf qfits-6.2.0.tar.gz
cd qfits-6.2.0/
sed -i.bak "s/O_CREAT/O_CREAT, S_IRUSR\|S_IWUSR/g" src/qfits_memory.c # Bug fix
./configure
make
make install
cd ..
rm -rf qfits-6.2.0*

### How to use qfits:
## - Print filename, object, exposure and filter
#dfits /gls/data/raw/2015-04-12/ECAM.2*fits | fitsort object exptime filter
## - Search for an object
#dfits ECAM.*fits | fitsort object |grep Gaia
## - Find flats and copy them to the current directory:
#dfits /gls/data/raw/2015-04-12/ECAM.2*fits | fitsort object filter | grep flat | awk '{printf("cp %s .\n", $1)}' | bash

wget ftp://heasarc.gsfc.nasa.gov/software/lheasoft/fv/fv5.4_pc_linux64.tar.gz
tar -zxvf fv5.4_pc_linux64.tar.gz
mkdir -p /opt/
mv fv5.4/ /opt/
cat << EOF > /usr/local/bin/fv
#!/bin/bash
EXEC='/opt/fv5.4/fv'
eval \$EXEC "\$@"
EOF
chmod 755 /usr/local/bin/fv
rm -f fv5.4_pc_linux64.tar.gz

