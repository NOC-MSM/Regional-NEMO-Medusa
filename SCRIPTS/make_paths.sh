#!/bin/bash

#***********************
#make_paths.sh
#***********************

# This script should be editted.
# It sets all the directory paths that are subsequently
# used to compile NEMO/OPA and XIOS.
# These paths are also required to run NEMO, XIOS and various tools
#
# Assumed:
# git clone https://github.com/NOC-MSM/NEMO-RELOC.git NEMO-RELOC


# Set the configuration name that describes the NEMO executable
# export CONFIG=TESTCOMPILE
# export CONFIG=NEMOhorizTS # NEMO exec with hardwired horizontally uniform T,S
# export CONFIG=NEMOconstTS # NEMO exec with hardwired constant T,S

# Set the path structure for the WORKING DIRECTORY. WDIR is the base directory where everything happens 
export WORK=/work/n01/n01/$USER
export WDIR=$WORK/EA_R12_BIO # Optionally WDIR shares the same name as the repository.

# Set the NEMO version
export NEMO_VER=4.0.6

# The following can then be automatically defined
export NEMO=$WDIR/nemo_vr4.06               # base NEMO source and build path 
export XIOS_DIR=$WDIR/XIOS/xios-2.5_r2022   # base XIOS source and build path

#export CDIR=$NEMO/cfgs
#export EXP=$WDIR/RUN_DIRECTORIES/EXPconstTS
#export XIOS1_DIR=$WDIR/BUILD_EXE/XIOS/xios-1.0

export TDIR=$NEMO/tools       # base tools source and build directory
export DOMAIN=$TDIR/DOMAINcfg # base directory for building domain configuration file

# export DOWNLOADS=$WDIR/DOWNLOADS

# Set some HPC parameters to control compilation
#export HPC_TARG="archer2-4c"
export HPC_TARG="archer2"
export COMPILER="cray"
