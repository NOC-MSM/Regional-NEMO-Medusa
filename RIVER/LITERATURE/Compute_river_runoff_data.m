% Creation of the river forcings variable used for NEMO ORCHESTRA (EAfrica
% Configuration)

% ----- Main steps ------
% to convert from flow in m3/s to kg/m2/s
% density = 1000 kg/m3
% rorunoff = flow * density / area of  grid box  in kg/m2/s
% for NEMO
% dx=ncread('coordinates_CS15r.nc','e1t');
% dy=ncread('coordinates_CS15r.nc','e2t');
% nemo_area=dx.*dy;
% -----------------------


clear all
clc
close all

%- Go to the location of your datasets
cd V:\3D_MODELING\EAFRICA\PROJECT_NEMO_MEDUSA\RIVER\LITERATURE
%- Read in the domain_cfg to get the latitudes and longitudes of your domain
Lat = ncread('domain_cfg.nc','nav_lat'); % 279 x 614
Lon = ncread('domain_cfg.nc','nav_lon'); % 279 x 614

%- Convert the matrix into a vector
Lat_EA=Lat(1,:)'; % 614
Lon_EA=Lon(:,1); % 279
clear Lat Lon

%- Pairing of the latitude and longitude coordinates. So I get all the
% possible combination of latitude and longitude
C=[]; % Contains all the latitude and the associated longitude. Normally, it should have the size (length(Lat_EA) x length(Lon_EA))

for i = 1 : length(Lat_EA) % lat
    for j = 1 : length(Lon_EA) % lon
    C = [C ; Lon_EA(j) Lat_EA(i)]; % 7068 x 2
    end
end
    
%- Use the mask to check if the river coordinate is on land or at sea. The
% mask I use here is from domain_cfg (variable top_level)
% 1 = sea
% 0 = land
Mask = ncread('domain_cfg.nc','top_level'); % 279 x 614 (lon x lat)

% Read first the river coordinates. The coordinates of the river mouths (latitude and longitude in decimals) 
% have been obtained online. From the top of the matrix to the bottom, this is : Tana, Galana,
% Pangani, Wami, Rufiji and Ruvuma.
load RIVERS_COORD % first column = longitude, second column = latitude

river_nb = 6; % choose here the river to analyse
nb_point = 3; % choose here the number of points to look for the nearest neighbour algorithm.

% Find what are the closest indexes of the river coordinates RIVERS_COORD inside the matrix C.
Idx = knnsearch(C,RIVERS_COORD,'K',nb_point); % use the nearest neighbour algorithm (the second column inside
% Idx corresponds to the second other point that is closest to the coordinate of interest)
clear q r
  for i = 1 : nb_point
    q(i) = find(Lon_EA == C(Idx(river_nb,i),1)); % longitude 
    r(i) = find(Lat_EA == C(Idx(river_nb,i),2)); % latitude
  end
    
p=[];
   for i = 1 : length(q) 
   Check = Mask(q(i),r(i));
   if Check == 1
       disp('Stop') % stop because it's good as the point close to the river mouth is in the sea
       pause(3)
       p=[p;i]; % indicate what value of nb_point is not in land
   else
   end
   end
   
%    imagesc(Lon_EA,-Lat_EA,Mask') % lat x lon
%    hold on
%    plot(Lon_EA(115),-Lat_EA(539),'+r','MarkerSize',10) % closest point for the first river

   
   %%
% Report here the closest coordinates INDEXES for each of the river mouth 
% Tana : Lon_EA(24) Lat_EA(109) (1st closest point was on the sea)
% Galana : Lon_EA(22) Lat_EA(102) (1st closest point was on the sea)
% Pangani : Lon_EA(8) Lat_EA(75) (3rd closest point was on the sea)
% Wami : Lon_EA(6) Lat_EA(66) (2nd closest point was on the sea)
% Rufiji : Lon_EA(12) Lat_EA(47) (3rd closest point was on the sea)
% Ruvuma : Lon_EA(26) Lat_EA(14) (1st closest point was on the sea)

SELECTED_COORD = [24 109; 22 102; 8 75; 6 66;12 47; 26 14]; % lon x lat (indexes !)


% I need first to generate a mask with only the location of the rivers (1 = river mouth, 0 = land) and 
% that contains the climatology of the river discharge
  load RIVERS_FLOW % contains variables {Tana, Galana, Pangani, Wami, Rufiji, Ruvuma} with the climatology of discharge
  Mask_river(1:57,1:124,1:12) = 0; % initialisation

  Mask_river(SELECTED_COORD(1,1),SELECTED_COORD(1,2),:) = Tana;
  Mask_river(SELECTED_COORD(2,1),SELECTED_COORD(2,2),:) = Galana;
  Mask_river(SELECTED_COORD(3,1),SELECTED_COORD(3,2),:) = Pangani;
  Mask_river(SELECTED_COORD(4,1),SELECTED_COORD(4,2),:) = Wami;
  Mask_river(SELECTED_COORD(5,1),SELECTED_COORD(5,2),:) = Rufiji;
  Mask_river(SELECTED_COORD(6,1),SELECTED_COORD(6,2),:) = Ruvuma;
    
% Once I got the mask with the river discharge climatology,I need to do
% some units conversion
   
% Calculation of the rorunoff : rorunoff = flow * density / area of grid box
   
 dx = ncread('domain_cfg.nc','e1t'); % 279 x 614
 dy = ncread('domain_cfg.nc','e2t'); % 279 x 614

 nemo_area=dx.*dy;

 for i = 1 : 12 % months
 rorunoff(:,:,i) = Mask_river(:,:,i) * 1000 ./ nemo_area(:,:);
 end

%% 
 % Verification
   imagesc(Lon_EA,-Lat_EA,Mask') % lat x lon
   hold on
   plot(Lon_EA(24),-Lat_EA(109),'+r','MarkerSize',10) % closest point for the first river
   plot(Lon_EA(22),-Lat_EA(102),'+r','MarkerSize',10)
   plot(Lon_EA(8),-Lat_EA(75),'+r','MarkerSize',10)
   plot(Lon_EA(6),-Lat_EA(66),'+r','MarkerSize',10)
   plot(Lon_EA(12),-Lat_EA(47),'+r','MarkerSize',10)
   plot(Lon_EA(26),-Lat_EA(14),'+r','MarkerSize',10)
