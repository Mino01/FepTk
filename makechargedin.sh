#!/bin/bash
#
# Usage: makechargein LIGNAME CHARGE
# 
# Samuel Genheden 2011-2012
# Edit MO 2015-11-19


reslowA=$1
resnamA=`echo $reslowA | tr '[a-z]' '[A-Z]'`
charge=$2
#spinm=$3 #not needed

antechamber -i ${reslowA}_esp.out -fi gout -o ${reslowA}.in -fo prepi -nc $charge -c resp -rn $resnamA -a ${reslowA}.pdb -fa pdb -ao name

#copy pdb

if [ ! -z NEWPDB.PDB ] ; then 

    cp NEWPDB.PDB ${reslowA}-resp.pdb 

fi 

