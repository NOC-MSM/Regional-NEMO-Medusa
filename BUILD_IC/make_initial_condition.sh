
mkdir CREATION_IC_EA
cd /work/n01/n01/valegu/CREATION_IC_EA

# I Took the flood filled file I generated previously in 2018 (same resolution so can still use it): 
# Those files are called : 
# vosaline_ORCA0083-N06-EAfrica_2013
# votemper_ORCA0083-N06-EAfrica_2013

module load nco

$TDIR/WEIGHTS/scripgrid.exe namelist_reshape_bilin_initcd_votemper
$TDIR/WEIGHTS/scrip.exe namelist_reshape_bilin_initcd_votemper
$TDIR/WEIGHTS/scripinterp.exe namelist_reshape_bilin_initcd_votemper
$TDIR/WEIGHTS/scripinterp.exe namelist_reshape_bilin_initcd_vosaline

# I have also created the file initcd_depth_R12.nc:
ncap2 -O -s gdept_3D[z,y,x]=gdept initcd_votemper.nc tmp.nc
ncap2 -O -s gdept_3D[time_counter,z,y,x]=gdept_3D tmp.nc initcd_depth_R12.nc

# I have also created the file initcd_mask.nc:
ncks -d time_counter,0,0,1 -v so cut_down_20130105d05T_EA31FES_grid_T.nc sosie_initcd_mask.nc
ncap2 -O -s 'where(so <=30.) so=0' sosie_initcd_mask.nc sosie_initcd_mask.nc
ncap2 -O -s 'where(so >1.) so=1' sosie_initcd_mask.nc sosie_initcd_mask.nc
ncatted -a _FillValue,so,o,d,0. sosie_initcd_mask.nc

scp -rp namelist_reshape_bilin_initcd_votemper namelist_reshape_bilin_initcd_sosie_mask
/work/n01/n01/valegu/EA_R12/nemo_v4.06/tools/WEIGHTS/scripinterp.exe namelist_reshape_bilin_initcd_sosie_mask
this creates sosie_initcd_maskInterp.nc

ncrename -v vosaline,mask sosie_initcd_maskInterp.nc
mv sosie_initcd_maskInterp.nc initcd_maskInterp.nc
