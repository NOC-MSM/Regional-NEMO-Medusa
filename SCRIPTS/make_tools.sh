#!/bin/bash

#:'
#
#***********************
#make_tools.sh
#***********************
#

  # Ensure the correct modules are loaded for ARCHER2
  # Load modules listed in /work/n01/shared/nemo/setup
  # Tested 14Jan22
  module swap craype-network-ofi craype-network-ucx
  module swap cray-mpich cray-mpich-ucx
  module load cray-hdf5-parallel/1.12.0.7
  module load cray-netcdf-hdf5parallel/4.7.4.7


  # cd $NEMO
  # for ext_name in tools
  #   do
  #   ext=`svn propget svn:externals | grep $ext_name | cut -c2-`
  #   echo $ext
  #   svn co http://forge.ipsl.jussieu.fr/nemo/svn/$ext
  # done


  # Make an adjustment to the DOMAINcfg source code to accomodate more varied vertical coords
  cp /work/n01/n01/jdha/transfer/DOMAINcfg/src/domzgr.f90.melange $TDIR/DOMAINcfg/src/domzgr.f90
 
  # Apply patches for the weight file code
  cd $NEMO/tools/WEIGHTS/src
  patch -b < /work/n01/n01/annkat/FILES_START/NEMO-FABM-ERSM/patch_files/scripinterp_mod.patch
  patch -b < /work/n01/n01/annkat/FILES_START/NEMO-FABM-ERSM/patch_files/scripinterp.patch
  patch -b < /work/n01/n01/annkat/FILES_START/NEMO-FABM-ERSM/patch_files/scrip.patch
  patch -b < /work/n01/n01/annkat/FILES_START/NEMO-FABM-ERSM/patch_files/scripshape.patch
  patch -b < /work/n01/n01/annkat/FILES_START/NEMO-FABM-ERSM/patch_files/scripgrid.patch


  # compile tools
  cd $NEMO/tools
  ./maketools -m archer2_cray -n NESTING
  ./maketools -m archer2_cray -n REBUILD_NEMO
  ./maketools -m archer2_cray -n WEIGHTS
  ./maketools -m archer2_cray -n DOMAINcfg


  # Make SOSIE tool.
  #$SCRIPTS/install_sosie.sh

  # Install PyNEMO
  #$SCRIPTS/install_pynemo.sh

  cd $WDIR/SCRIPTS
