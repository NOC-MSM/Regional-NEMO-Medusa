#!/bin/bash

#:'
#
#***********************
#make_xios.sh
#***********************
#
#Checkout and compile the XIOS2.5 executable for I/O management
#You need to obtain a NEMO account http://forge.ipsl.jussieu.fr/nemo/register
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


#download xios
svn co -r2022 http://forge.ipsl.jussieu.fr/ioserver/svn/XIOS/branchs/xios-2.5/  $XIOS_DIR
cd $XIOS_DIR

#copy the arch files to build location (I took them from James)
scp -rp /work/n01/n01/jdha/test/xios/arch/arch-archer2_cray.* $XIOS_DIR/arch/.

#compile xios
./make_xios --prod --arch ${HPC_TARG}_${COMPILER} --netcdf_lib netcdf4_par --job 16 --full

# NOTE : Now it compiled well after first try, without having to change the FC_MODSEARCH (14/01/2022). But I still did step below and recompiled.

# First time compile will fail
# got to $XIOS_DIR/tools/FCM/lib/Fcm/Config.pm and change
# FC_MODSEARCH => '',             # FC flag, specify "module" path
#to
#FC_MODSEARCH => '-J',           # FC flag, specify "module" path
sed -i "s/FC_MODSEARCH => ''/FC_MODSEARCH => '-J'/g" tools/FCM/lib/Fcm/Config.pm

#recompile xios
./make_xios --prod --arch ${HPC_TARG}_${COMPILER} --netcdf_lib netcdf4_par --job 16 --full

echo "Executable is $XIOS_DIR/bin/xios_server.exe"

#######################################
cd $WDIR/SCRIPTS
