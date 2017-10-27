#!/bin/bash

#usage: makechargebcc <PDB_FILE> <MOL> <CHARGE> <SPINM> <RESN>

PDB_FILE=$1
MOL=$2 
CHARGE=$3
SPINM=$4 #not needed
RESN=$(echo "$MOL" | awk '{print toupper($0) }')

#standard test

if [ ! -z $PDB_FILE ] ; then 
  echo "Preparing bcc charges from $PDB_FILE"
else 
  echo "Pdb file not found."
fi 

antechamber -i $PDB_FILE -fi pdb -o $MOL-bcc.in -fo prepi -nc $CHARGE -c bcc -rn $RESN -at gaff


