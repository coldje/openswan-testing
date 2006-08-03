#!/bin/sh

# assumes that 
#          ROOTDIR=    set to root of source code.
#          OBJDIRTOP=  set to location of object files
#

echo "file $rootdir/OBJ.linux.i386/programs/readwriteconf/readwriteconf" >.gdbinit
echo "set args --rootdir=$rootdir/testing/baseconfigs/all --config $rootdir/testing/baseconfigs/west/etc/ipsec.conf >OUTPUT/west-flat.conf-out" >>.gdbinit

${OBJDIRTOP}/programs/readwriteconf/readwriteconf --rootdir=${ROOTDIR}/testing/baseconfigs/all --config ${ROOTDIR}/testing/baseconfigs/west/etc/ipsec.conf 

