#!/bin/bash

#create dat file from frequency calculation
#define control file for DFT frequency calculation for turbomole.

#usage: makecontrolfreq MOL CHARGE SPINM

MOL=$1 #without .pdb extension
CHARGE=$2 # e.g. 1 or -1
SPINM=$3 #NOT NEEDED

#create a new control file from pdb

cat<<EOF > chpdb-control.in 
${MOL}.pdb
c

n
NO
EOF

changepdb < chpdb-control.in


BASIS="def2-SV(P)"

TITLE="Torsion parameters for $MOL"

cat <<EOF> d.in
${TITLE}
y
ired
*
bb all ${BASIS}
#return
*
eht
#return
${CHARGE}
y
*
dft
func
b-lyp 
on
#return
*
EOF

define < d.in > d.out


echo "----------Basis info------------"
#check the basis information, same as bl command
grep "basis =" control  
echo "--------------------------------"

