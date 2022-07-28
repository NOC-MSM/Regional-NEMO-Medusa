#!/bin/bash

#:'
#
#***********************
#make_nemo.sh
#***********************
#
# Checkout and compile the NEMO executable for physics only simulations
#
# You need to obtain a NEMO account http://forge.ipsl.jussieu.fr/nemo/register
#
#Bare in mind that NEMO is being compiled for use with a particular version of
#XIOS. Ensure edits to ``%XIOS_HOME`` in the ``arch-*`` file are consistent with
#the XIOS build.
# Also any code hardwiring (E.g. user defined initial conditions) must be put
# into MY_SRC before makenemo is executed.
#
#'
#::

cd $WDIR

# Ensure the correct modules are loaded for ARCHER2
# Load modules listed in /work/n01/shared/nemo/setup
# Tested 14Jan22
module swap craype-network-ofi craype-network-ucx
module swap cray-mpich cray-mpich-ucx
module load cray-hdf5-parallel/1.12.0.7
module load cray-netcdf-hdf5parallel/4.7.4.7

# Checkout the code from the paris repository
svn co http://forge.ipsl.jussieu.fr/nemo/svn/NEMO/releases/r4.0/r4.0.6/ nemo_vr4.06


# copy the appropriate architecture file into place
scp -rp /work/n01/n01/jdha/test/nemo/arch/arch-archer2_cray.* $NEMO/arch/.
# you need to update the path :
vi $NEMO/arch/arch-archer2_cray.fcm (change the path to xios: /work/n01/n01/valegu/EAFRICA/XIOS/xios-2.5 , but update it with your username and path)

# Change one line of the Config.pm:
cd $NEMO/ext/FCM/lib/Fcm
sed -e "s/FC_MODSEARCH => '',  /FC_MODSEARCH => '-J',/" Config.pm > tmp_file
mv tmp_file Config.pm


# Build from a reference configuration. This only uses OCE module
cd $NEMO
./makenemo -n $CONFIG -r AMM12  -m ${HPC_TARG}_${COMPILER} -j 16

# It should work well!
