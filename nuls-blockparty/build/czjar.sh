#!/bin/bash
 
reldir=`dirname $0`

cd $reldir
echo "reldir is: "
echo $reldir

absoluteDIR=`pwd`
echo "absoluteDIR is: "
echo $absoluteDIR

cd '..'
hmdir=`pwd`
echo "hmdir Directory is ${hmdir}"


cd '../'
parentDIR=`pwd`
echo "parentDIR Directory is ${parentDIR}"



MAINJAR="${hmdir}/outer/nuls-blockparty-1.0.0.jar" 
NEWFILE="${parentDIR}/NULS-WALLET/Modules/Nuls/nuls-blockparty/1.0.0/nuls-blockparty-1.0.0.jar"

echo "NEWFILE is $NEWFILE"


echo "parentDIR is ${parentDIR}"
cp ${MAINJAR} ${NEWFILE}

