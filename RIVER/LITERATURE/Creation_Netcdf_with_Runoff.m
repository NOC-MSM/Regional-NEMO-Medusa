% Need to run beforehand the script called "Compute_river_runoff_data"
% Creation of the Netcdf file that contains the runoff variable
time_counter=1:12;
% Create a netCDF file.
ncid = netcdf.create('EA_R12rivers.nc','NC_WRITE');

% Define a dimension in the file.
dim1 = netcdf.defDim(ncid,'lon',57);
dim2 = netcdf.defDim(ncid,'lat',124);
dim3 = netcdf.defDim(ncid,'time_counter',netcdf.getConstant('NC_UNLIMITED'));  

% Define a new variable in the file.
varid1 = netcdf.defVar(ncid,'time_counter','double',dim3); 
varid2 = netcdf.defVar(ncid,'lat','double',dim2); 
varid3 = netcdf.defVar(ncid,'lon','double',dim1); 
varid4 = netcdf.defVar(ncid,'rorunoff','double',[dim1,dim2,dim3]); 

% Leave define mode and enter data mode to write data.
netcdf.endDef(ncid);

% Write data to variable.
netcdf.putVar(ncid,varid1,0,12,time_counter);
netcdf.putVar(ncid,varid2,Lat_EA);
netcdf.putVar(ncid,varid3,Lon_EA);
netcdf.putVar(ncid,varid4,rorunoff);

% Re-enter define mode.
netcdf.reDef(ncid);

% Create an attribute associated with the variable.
%  netcdf.putAtt(ncid,0,'units','degrees');

% Verify that the attribute was created.
% [xtype xlen] = netcdf.inqAtt(ncid,0,'my_att')

netcdf.close(ncid);