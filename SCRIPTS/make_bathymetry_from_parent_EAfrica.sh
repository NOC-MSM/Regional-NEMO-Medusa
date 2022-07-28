#!/bin/bash

#:'
#
#*************************************
#make_bathymetry_from_parent_EAfrica.sh
#*************************************
#
# In the following the bathmetry file is constructed from the gridded bathymetry
# of the parent model. This dataset is available on the JASMIN compute service. E.g.
# at ``/gws/nopw/j04/nemo_vol6/acc/eORCA12-N512-ay652/domain/eORCA12_bathymetry_v2.4.nc``
#
# The process is similar to ``make_bathymetry_from_gebco.sh``, which creates the
# bathymetry from a GEBCO bathymetric data. Though here preprocessing steps are
# not required before the bathymetry is mapped to the child grid using the SCRIP
# tools.
# '
#::


  cd $DOMAIN

  # Ensure the correct modules are loaded for ARCHER2
  # Load modules listed in /work/n01/shared/nemo/setup
  # Tested 14Jan22
  module swap craype-network-ofi craype-network-ucx
  module swap cray-mpich cray-mpich-ucx
  module load cray-hdf5-parallel/1.12.0.7
  module load cray-netcdf-hdf5parallel/4.7.4.7

  # Obtain the bathymetry from the ORCA12 global model from JASMIN. The e(xtended)ORCA domain has a higher latitude reach. 
  # Or on ARCHER you can take it from an existing directory E.g. /gws/nopw/j04/nemo_vol6/acc/eORCA12-N512-ay652/domain/eORCA12_bathymetry_v2.4.nc 
  wget http://gws-access.jasmin.ac.uk/public/nemo/runs/ORCA0083-N06/domain/bathymetry_ORCA12_V3.3.nc -O ./bathymetry_ORCA12_V3.3.nc

  # Load modules
  module load nco
  ncks -d x,3906,3962 -d y,1355,1478 ./bathymetry_ORCA12_V3.3.nc -O cropped_bathy.nc 

  #remove weirdness with negative bathymetry and make minimum bathymetry
  #equal to 10 m (resolve any possible wet-drying problems)
  # Note : Couldn't make ncap2 work on Archer full system (14/01/2022)
  ncap2 -s 'where(Bathymetry < 0) Bathymetry=0' cropped_bathy.nc tmp1.nc
  ncap2 -s 'where(Bathymetry < 10 && Bathymetry > 0) Bathymetry=10' tmp1.nc -O bathy_meter.nc
  rm tmp1.nc


  #ln -s $DOWNLOADS/bathymetry_ORCA12_V3.3.nc $DOMAIN/bathymetry_ORCA12_V3.3.nc
  #rsync -uvt $DOWNLOADS/bathymetry_ORCA12_V3.3.nc $DOMAIN/bathymetry_ORCA12_V3.3.nc

  # Execute first SCRIP process::
  ## Generate the new coordinates file with the namelist.input settings using AGRIF tool
  # Edit job script
  #sed "s?XXX_TDIR_XXX?$TDIR?g" $DOMAIN/job_create_SCRIP_template.slurm > $DOMAIN/job_create_SCRIP.slurm

  # Submit the coordinates creation as a job (uses namelist_reshape_bilin_ORCA12 for settings)
  #cd $DOMAIN
  #sbatch   job_create_SCRIP.slurm 

# This batch script uses the SCRIP tool to perform a number of steps:
# Firstly, $TDIR/WEIGHTS/scripgrid.exe namelist_reshape_bilin_ORCA12
#  Output files::
#    remap_nemo_grid_gebco.nc
#    remap_data_grid_gebco.nc
#'
# Then, execute 2nd SCRIP process:
# $TDIR/WEIGHTS/scrip.exe namelist_reshape_bilin_ORCA12
#  Output files::
#    data_nemo_bilin_gebco.nc

# Finally, execute third SCRIP process:
# $TDIR/WEIGHTS/scripinterp.exe namelist_reshape_bilin_ORCA12
#  Output files::
#    bathy_meter.nc
#

cd $WDIR/SCRIPTS