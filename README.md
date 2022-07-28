# EAFRICA_R12
# Relocatable NEMO - MEDUSA

An example configuration of the East African Coast, demonstrating how to setup new regional domains using the NEMO framework **coupled with MEDUSA**.

This model configuration has been developed through the SOLSTICE (Sustainable Oceans, Livelihoods and food Security Through Increased Capacity in Ecosystem research in the Western Indian Ocean) Project.

## NEMO - MEDUSA regional configuration of East African Coast 

### Model Summary

A specific region of focus includes exploring East African Coast (38.43°E to 43.06°E and 11.48°S to 1.35°S)

The model grid has 1/12° lat-lon resolution and 75 vertical levels. Featuring:

- NEMO v4.0.6
- XIOS v2.5
- FES2014 tides
- Boundary conditions from the Global model ORCA0083-N06
- Freshwater forcing (only river discharge included)
- ERA5 forcings 

![Bathymetry_1_12_resolution_and_river_mouths](https://user-images.githubusercontent.com/30412310/180629607-35b46470-b105-4a57-8d47-1045acb01d0b.png)


### Model Setup

The following process is followed to build and get started with this configuration

`git clone https://github.com/NOC-MSM/Regional-NEMO-Medusa.git` <br />
`cd Regional-NEMO-Medusa`
