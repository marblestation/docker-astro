#!/bin/bash

mkdir -p /iraf/iraf
cd /iraf/iraf
wget ftp://iraf.noao.edu/iraf/v216/PCIX/iraf.lnux.x86_64.tar.gz
tar -zxvf iraf.lnux.x86_64.tar.gz
rm iraf.lnux.x86_64.tar.gz
./install -s << EOF
/iraf/iraf
/iraf/imdirs
/iraf/cache
/usr/local/bin
yes
EOF

#su marble - -c "cd && mkiraf << EOF
#xterm
#EOF
#"

#To begin using the system simply log in as any user and from the
#directory you wish to use as your iraf login directory type:
#
#          % mkiraf     # create a login.cl file
#          % cl         # start IRAF

#mkdir -p /iraf/x11iraf
#cd /iraf/x11iraf
#wget http://iraf.noao.edu/iraf/ftp/iraf/x11iraf/x11iraf-v2.0BETA-bin.linux.tar.gz
#tar -zxvf x11iraf-v2.0BETA-bin.linux.tar.gz
#rm x11iraf-v2.0BETA-bin.linux.tar.gz
## All values by default (Keep hitting Enter for all prompts)
#./install

#cd $APPS_SANDBOX/bin
#wget http://www.astronomy.ohio-state.edu/~khan/iraf/iraf
#chmod 755 iraf

#cd $HOME
#mkdir iraf
#cd iraf
## Select "xgterm" as your IRAF shell when prompted
#mkiraf

cd /iraf/iraf/extern
./configure
# The next two lines will take some time to complete, even with fast internet. Be patient.
make adccdrom ctio cfh12k esowfi mscdb mscred stsdas nfextern optic
make deitab euv mem0 mtools rvsao song sqiid stecf ucsclris upsqiid xdimsum
