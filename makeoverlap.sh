#!/bin/sh 

echo "####################################"
echo "##         MAKEOVERLAP            ##"
echo "####################################" 

echo "Creating FEP results, overlap .... "
echo ""

#usage: makeoverlap 

INPUT_NUM_LAMBDA=$1
$OVERLAP/overlap<<EOI > overlap-mo1
${INPUT_NUM_LAMBDA}
mbar-mmscn-${INPUT_NUM_LAMBDA}l-prot
EOI


