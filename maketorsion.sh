#!/bin/bash

#creates dat file from control file after frequency calculation. 
#requires manual step of creating a file atmtyp with the format:
#from .in file with reordering according to pdb from rasp
#

#-----atmtyp---------- 
#Parameters for G2 = p-CN-benzoate, 24/11-15

#G2
#C1    ca    
#C2    ca    
#C3    ca    
#C4    ca    
#C5    ca    
#C6    ca    
#C7    cg    
#N1    n1    
#C8    c     
#O1    o     
#O2    o      
#H1    ha      
#H2    ha      
#H3    ha    
#H4    ha   
#----------------------


if [ ! -z atmtyp ] ; then 
echo "found atmtyp file in directory"

cat<<EOF > des.in 
c



1
y
1


a
atmtyp
logfile

n



EOF

describe < des.in

else
   echo "error: no atmtyp file in directory"
fi


