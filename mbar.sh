
####################################################################
# THIS IS BAR SCRIPT FOR SANDER.OUT TO BENNETT ACCEPTANCE RATIO FEP
####################################################################
#
# 13 lambda 
# prot wat 
#

#set SANDERTOMBAR variable.

for x in prot wat ; do

        for lambda_val in "0.00" "0.05" "0.10" "0.20" "0.30" "0.40" "0.50" "0.60" "0.70" "0.80" "0.90" "0.95" "1.00" ; do
        lam=$(echo $lambda_val | cut -c 1,3-4)

$SANDERTOMBAR/sandertombar<<EOI
$x-$lambda_val-sander.out4
mbar-mmscn-$x.$lam
13
0.00 0.05 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 0.95 1.00
EOI
        done

$PYMBAR/pymbar_alchemical.py mbar-mmscn-$x 300 0 0.00 0.05 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 0.95 1.00 >mbar-results-$x

done

