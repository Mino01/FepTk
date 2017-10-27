#!/bin/bash

### MO 2015-03-01

#2 lam: 0.000 1.000
#3 lam: 0.000 0.500 1.000
#4 lam: 0.000 0.333 0.666 1.000
#5 lam: 0.000 0.250 0.500 0.750 1.000
#9 lam: 0.000 0.125 0.250 0.375 0.500 0.625 0.750 0.875 1.000
#25 lam: "0.000" "0.025" "0.050" "0.075" "0.100" "0.150" "0.200"
#"0.250" "0.300" "0.350" "0.400" "0.450" "0.500" "0.550" "0.600"
#"0.650" "0.700" "0.750" "0.800" "0.850" "0.900" "0.925" "0.950" "0.975" "1.000"
#


suffix="$1l"

makeresults2 () {

for x in prot wat ; do
for state in v0 ; do

        for lambda_val in "0.000" "1.000" ; do
        lam=$(echo $lambda_val | cut -c 1,3-5)

ambtombar<<EOI
$x-lam$lam-sander-$state.out4
mbar-mmscn-$suffix-$x.$lam
2
0.000 1.000
EOI
        done

#pymbar_alchemical.py mbar-mmscn-$suffix-$x 300 0 0.000 1.000 >mbar-results-$suffix-$x

done
done

}


makeresults3 () {

for x in prot wat ; do
for state in v0 ; do 

        for lambda_val in "0.000" "0.500" "1.000" ; do
        lam=$(echo $lambda_val | cut -c 1,3-5)

ambtombar<<EOI
$x-lam$lam-sander-$state.out4
mbar-mmscn-$suffix-$x.$lam
3
0.000 0.500 1.000
EOI
        done

#pymbar_alchemical.py mbar-mmscn-$suffix-$x 300 0 0.000 0.500 1.000 >mbar-results-$suffix-$x

done
done 

}


makeresults4 () {

for x in prot wat ; do
for state in v0 ; do

        for lambda_val in "0.000" "0.333" "0.666" "1.000" ; do
        lam=$(echo $lambda_val | cut -c 1,3-5)

ambtombar<<EOI
$x-lam$lam-sander-$state.out4
mbar-mmscn-$suffix-$x.$lam
4
0.000 0.333 0.666 1.000
EOI
        done

#pymbar_alchemical.py mbar-mmscn-$suffix-$x 300 0 0.000 0.333 0.666 1.000 >mbar-results-$suffix-$x

done
done

}


makeresults5 () {

for x in prot wat ; do
for state in v0 ; do

        for lambda_val in "0.000" "0.250" "0.500" "0.750" "1.000" ; do
        lam=$(echo $lambda_val | cut -c 1,3-5)

ambtombar<<EOI
$x-lam$lam-sander-$state.out4
mbar-mmscn-$suffix-$x.$lam
5
0.000 0.250 0.500 0.750 1.000
EOI
        done

#pymbar_alchemical.py mbar-mmscn-$suffix-$x 300 0 0.000 0.250 0.500 0.750 1.000 >mbar-results-$suffix-$x

done
done

}


makeresults9 () {

for x in prot wat ; do
for state in v0 ; do

        for lambda_val in 0.000 0.125 0.250 0.375 0.500 0.625 0.750 0.875 1.000 ; do
        lam=$(echo $lambda_val | cut -c 1,3-5)

ambtombar<<EOI
$x-lam$lam-sander-$state.out4
mbar-mmscn-$suffix-$x.$lam
9
0.000 0.125 0.250 0.375 0.500 0.625 0.750 0.875 1.000
EOI
        done

#pymbar_alchemical.py mbar-mmscn-$suffix-$x 300 0 0.000 0.125 0.250 0.375 0.500 0.625 0.750 0.875 1.000 >mbar-results-$suffix-$x

done
done

}


makeresults25 () {

for x in prot wat ; do
#for state in v0 ; do

        for lambda_val in "0.000" "0.025" "0.050" "0.075" "0.100" "0.150" "0.200" "0.250" "0.300" "0.350" "0.400" "0.450" "0.500" "0.550" "0.600" "0.650" "0.700" "0.750" "0.800" "0.850" "0.900" "0.925" "0.950" "0.975" "1.000" ; do

        lam=$(echo $lambda_val | cut -c 1,3-5)

ambtombar<<EOI
$x-${lambda_val}-sander.out4
mbar-mmscn-$suffix-$x.$lam
25
0.000 0.025 0.050 0.075 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.450 0.500 0.550 0.600 0.650 0.700 0.750 0.800
0.850 0.900 0.925 0.950 0.975 1.000
EOI
        done

#pymbar_alchemical.py mbar-mmscn-$suffix-$x 300 0 "0.000" "0.025" "0.050" "0.075" "0.100" "0.150" "0.200" "0.250" "0.300" "0.350" "0.400" "0.450" "0.500" "0.550" "0.600" "0.650" "0.700" "0.750" "0.800" "0.850" "0.900" "0.925" "0.950" "0.975" "1.000" >mbar-results-$suffix-$x

done
#done

}

#exceptions

makeresults24 () {

for x in prot wat ; do
#for state in v0 ; do

        for lambda_val in "0.000" "0.025" "0.050" "0.075" "0.100" "0.150" "0.200" "0.250" "0.300" "0.350" "0.400" "0.500" "0.550" "0.600" "0.650" "0.700" "0.750" "0.800" "0.850" "0.900" "0.925" "0.950" "0.975" "1.000" ; do

        lam=$(echo $lambda_val | cut -c 1,3-5)

ambtombar<<EOI
$x-${lambda_val}-sander.out4
mbar-mmscn-$suffix-$x$lam
24
0.000 0.025 0.050 0.075 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.500 0.550 0.600 0.650 0.700 0.750 0.800
0.850 0.900 0.925 0.950 0.975 1.000
EOI
        done

#pymbar_alchemical.py mbar-mmscn-$suffix-$x 300 0 "0.000" "0.025" "0.050" "0.075" "0.100" "0.150" "0.200" "0.250" "0.300" "0.350" "0.400" "0.450" "0.500" "0.550" "0.600" "0.650" "0.700" "0.750" "0.800" "0.850" "0.900" "0.925" "0.950" "0.975" "1.000" >mbar-results-$suffix-$x

done
#done

}



if  [ "$1" = "2"  ] ; then 

   makeresults2   

elif [ "$1" = "3"  ] ; then 

   makeresults3

elif [ "$1" = "4"  ] ; then

   makeresults4

elif [ "$1" = "5"  ] ; then 

   makeresults5

elif [ "$1" = "9"  ] ; then

   makeresults9

elif [ "$1" = "25"  ] ; then

   makeresults25

elif [ "$1" = "24"  ] ; then

   makeresults24

else 

   echo "Error in use of script."

fi 


