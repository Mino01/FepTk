#!/bin/bash 


cat <<EOF > md.mo2
G0
G1
G2
G3
G4
G5
G6
G7
EOF

while read p ; do 

guest=$( echo "$p" | awk '{ print tolower($0) }'  ) 
GUESTPDB=${guest}.pdb
HOSTPDB="temoa-mao.pdb"
HOSTGUESTPDB="temoa-${guest}.pdb"

count=12 
count=$(($count+1))

   echo "$p"
   echo "Guest is $guest "
   ##mkdir "$p"
   cd $p


for dir in n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 ; do         
         cd $dir 

            sbatch q-md-gpu-keb

         cd .. 
done 

      cd .. 

done < md.mo2

 
