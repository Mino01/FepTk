#!/bin/bash 

#creates ptraj.in file with residue name center.
#usage: makeptraj mdcrd4basename.mdcrd4 residuecenter

#usage: makeptraj <PRM> <MDCRD> <RES>

echo -n "Enter the name of prmtop file: "
read PRM
echo -n "Enter the name of mdcrd5 file: "
read MDCRD
#RES=$3
#########3 name of prmtop; prot.prm

#if [ "$prm" = "" ] ; then 
#   prm="prot.prm"
#else 
#   echo "non-standard prmtop in use" 
#fi 

cat << EOF > ptraj.in 
trajin $MDCRD
trajout $MDCRD-wrap trajectory
autoimage
go
quit
EOF

cpptraj $PRM ptraj.in 


