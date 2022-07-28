% Plot the river discharges obtained from literature around the East African Coast 
% Dataset of river discharge for the EAfrica modelling

clear all; clc; close all
%%

load RIVERS_FLOW

%%%%--- PANGANI (KORGOWE STATION)
plot(Pangani,'.-')
title('Pangani (Korogowe Station)')
ylabel('Discharge (m^3 s^-^1)')
MN={'J','F','M','A','M','J','J','A','S','O','N','D'};
set(gca,'xtick',1:1:12)
set(gca,'xticklabel',MN)

%%%%--- RUFIJI (STIEGLER STATION)
plot(Rufiji,'.-')
title('Rufiji (Stiegler Station)')
ylabel('Discharge (m^3 s^-^1)')
MN={'J','F','M','A','M','J','J','A','S','O','N','D'};
set(gca,'xtick',1:1:12)
set(gca,'xticklabel',MN)

%%%%--- WAMI (MANDERA STATION)
plot(Wami,'.-')
title('Wami (Mandera Station)')
ylabel('Discharge (m^3 s^-^1)')
MN={'J','F','M','A','M','J','J','A','S','O','N','D'};
set(gca,'xtick',1:1:12)
set(gca,'xticklabel',MN)

%%%%--- RUVUMA 
plot(Ruvuma,'.-')
title('Ruvuma')
ylabel('Discharge (m^3 s^-^1)')
MN={'J','F','M','A','M','J','J','A','S','O','N','D'};
set(gca,'xtick',1:1:12)
set(gca,'xticklabel',MN)

%%%%--- TANA RIVER
plot(Tana,'.-')
title('Tana (Garissa Station)')
ylabel('Discharge (m^3 s^-^1)')
MN={'J','F','M','A','M','J','J','A','S','O','N','D'};
set(gca,'xtick',1:1:12)
set(gca,'xticklabel',MN)

%%%%--- GALANA RIVER
plot(Galana,'.-')
title('Galana')
ylabel('Discharge (m^3 s^-^1)')
MN={'J','F','M','A','M','J','J','A','S','O','N','D'};
set(gca,'xtick',1:1:12)
set(gca,'xticklabel',MN)

%%%%--- PLOT ALL RIVERS TOGETHER
plot(Pangani,'.-')
hold on
plot(Rufiji,'.-')
plot(Wami,'.-')
plot(Ruvuma,'.-')
plot(Tana,'.-')
plot(Galana,'.-')
title('River Discharges')
ylabel('Discharge (m^3 s^-^1)')
MN={'J','F','M','A','M','J','J','A','S','O','N','D'};
set(gca,'xtick',1:1:12)
set(gca,'xticklabel',MN)
legend('Pangani','Rufiji','Wami','Ruvuma','Tana','Galana')

