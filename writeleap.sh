#!/bin/bash 

echo -n "Enter the residue name of the first ligand: "
read RES1
echo -n "Enter the residue name of the second ligand: "
read RES2 

cat<<EOF > leap.in 
addPath /hpc2n/eb/software/MPI/intel/2017.1.132-GCC-5.4.0-2.26/impi/2017.1.132/Amber/16-AmberTools-16-patchlevel-20-7/dat/leap/cmd
addPath /hpc2n/eb/software/MPI/intel/2017.1.132-GCC-5.4.0-2.26/impi/2017.1.132/Amber/16-AmberTools-16-patchlevel-20-7/dat/leap/parm

addPath /pfs/nobackup/home/t/tn05mo4/D3R_2016/FXR_Stage2/Leap
source leaprc.gaff
source leaprc.protein.ff14SB
source leaprc.water.tip3p

loadamberparams fxr.dat
loadamberprep $( echo ${RES1} | awk '{print tolower($0)}').in
loadamberprep $( echo ${RES2} | awk '{print tolower($0)}').in

x = loadpdb prot-lig.pdb
solvateOct x TIP3PBOX 10
saveamberparm x prot.prm prot.rst
savepdb x prot.pdb

x = loadpdb lig.pdb
solvateOct x TIP3PBOX 10
saveamberparm x wat.prm wat.rst
savepdb x wat.pdb
quit

EOF
