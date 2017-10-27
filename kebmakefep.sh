#!/bin/bash

###################################################
#INFO: This is a bash version of mkfep-pmemd.f 
# Martin O. 28/8 -15 
####################################################
#no need for recompilation or sed changes of batchnames
#Akka version.
#13 lambda values
#Note previously: ig=-1 sander.in2 file 
#Note: ig=-1 removed from sander.in2 file
#writes sander.in1, sander.in2, sander.in3, sander.in4
#writes q files
#fast optimized batchnames. 
#enhanced control of variables for turning on and off 
#shake, restart from rst, polarizable forcefield. 

########## READ fep.in file from stdinput ########

EQUILIBRATION=$(awk 'NR == 1' fep.in ) #ns
PRODUCTION_RUN=$(awk 'NR == 2' fep.in )  #ns
NBR_OF_LAMBDA=$(awk 'NR == 3' fep.in )
LIGAND1_RESIDUE_NAME=$(awk 'NR == 4' fep.in )
LIGAND2_RESIDUE_NAME=$(awk 'NR == 5' fep.in )
SCMASK1=$(awk 'NR == 6' fep.in )
SCMASK2=$(awk 'NR == 7' fep.in )
CLUSTER=$(awk 'NR == 8' fep.in )
RANDOM_SEED=$(awk 'NR == 9' fep.in )

######## re-name variables #################################
TIMASK1=$LIGAND1_RESIDUE_NAME
TIMASK2=$LIGAND2_RESIDUE_NAME

########## check for rst file ############################

if [ -f rst ] ; then
echo "Rst file in path. Will be used."
fi


#########################################################
#prep files ### 

if [ -f sub1-test.bash ] ; then
\rm sub1-test.bash
fi

cat << EOF > sub1-test.bash
sbatch q-prot-0.000
EOF


if [ -f sub2.bash ] ; then
\rm sub2.bash
fi

if [ -f sub-all.bash ] ; then 
\rm sub-all.bash  
fi 


############### Q FILE SPECS ###########################
############## batchname info  ##################

PROT_ID=$1
spec=$2 #specification for batchname 

##################################################

PROT_TIME=30
WAT_TIME=12
ID="SNIC2016-34-18"
PROCESSORS=28

EQUILIBRIUM_STEPS=$(awk 'BEGIN { print '$EQUILIBRATION'*1000/0.002 }')
PRODUCTION_STEPS=$(awk 'BEGIN { print '$PRODUCTION_RUN'*1000/0.002 }')
####################################################

for lam in "0.000" "0.050" "0.100" "0.200" "0.300" "0.400" "0.500" "0.600" "0.700" "0.800" "0.900" "0.950" "1.000" ; do 

for x in prot wat ; do 

#write sander.in1, sander.in2, sander.in3, sander.in4

cat << EOF > $x-$lam-sander.in1
TI 1 min, lambda=$lam
 &cntrl
  irest=0,ntx=1,
  imin=1,maxcyc=500,drms=0.0001,ntmin=2,
  ntc=2,ntf=1,
  cut=8.0,tishake=1,
  ntpr=100,ntwx=0,ntwv=0,ntwe=0,
  ntr=1,restraint_wt=100,
  restraintmask="!:WA= & !@H=",
  icfe=1,clambda=$lam,ifsc=1,
  timask1=":$TIMASK1",scmask1=":$TIMASK1@$SCMASK1",
  timask2=":$TIMASK2",scmask2=":$TIMASK2@$SCMASK2",
 &end
EOF

cat << EOF > $x-$lam-sander.in2
TI 2 NVT, lambda=$lam
 &cntrl
  irest=0,ntx=1,
  nstlim=10000,dt=0.002,
  ntb=1,temp0=300.0,ntt=3,gamma_ln=2.0,
  ntc=2,ntf=1,
  cut=8.0,tishake=1,
  ntpr=5000,ntwx=0,ntwv=0,ntwe=0,
  ntr=1,restraint_wt=100,
  restraintmask="!:WA= & !@H=",
  icfe=1,clambda=$lam,ifsc=1,
  timask1=":$TIMASK1",scmask1=":$TIMASK1@$SCMASK1",
  timask2=":$TIMASK2",scmask2=":$TIMASK2@$SCMASK2",
 &end
EOF

cat << EOF > $x-$lam-sander.in3
TI 3 NPT equilibr, lambda=$lam
 &cntrl
  irest=1,ntx=5,
  nstlim= $EQUILIBRIUM_STEPS,dt=0.002,
  temp0=300.0,ntt=3,gamma_ln=2.0,
  ntc=2,ntf=1,
  cut=8.0,tishake=1,
  ntb=2,ntp=1,pres0=1.0,taup=1.0,
  ntpr=5000,ntwx=0,ntwv=0,ntwe=0,
  icfe=1,clambda=$lam,ifsc=1,
  timask1=":$TIMASK1",scmask1=":$TIMASK1@$SCMASK1",
  timask2=":$TIMASK2",scmask2=":$TIMASK2@$SCMASK2",
 &end
EOF

cat << EOF > $x-$lam-sander.in4
TI 4 NPT production, lambda=$lam
 &cntrl
  irest=1,ntx=5,
  nstlim=$PRODUCTION_STEPS,dt=0.002,
  temp0=300.0,ntt=3,gamma_ln=2.0,
  ntc=2,ntf=1,
  cut=8.0,tishake=1,
  ntb=2,ntp=1,pres0=1.0,taup=1.0,
  ntpr=1000,ntwx=1000,ntwv=0,ntwe=0,
  icfe=1,clambda=$lam,ifsc=1,
  timask1=":$TIMASK1",scmask1=":$TIMASK1@$SCMASK1",
  timask2=":$TIMASK2",scmask2=":$TIMASK2@$SCMASK2",
  ifmbar=1, bar_intervall=1000,bar_l_min=0.000,bar_l_max=1.000,bar_l_incr=0.025,
 &end
EOF


#write q-files 

batchname=$PROT_ID-$x

if [ "$x" = "prot" ] ; then 
   TIME=$PROT_TIME
else 
   TIME=$WAT_TIME
fi 


cat << EOF > q-$x-$lam
#!/bin/bash
#SBATCH -n $PROCESSORS
#SBATCH -t $TIME:00:00
#SBATCH -A $ID
#SBATCH -J $batchname
module add amber/14

srun --cpu_bind=rank -n $PROCESSORS pmemd.MPI -O -i  $x-$lam-sander.in1 -o $x-$lam-sander.out1 -p $x.prm -c $x.rst          -r $x-$lam.mdrest1 -ref $x.rst
srun --cpu_bind=rank -n $PROCESSORS pmemd.MPI -O -i  $x-$lam-sander.in2 -o $x-$lam-sander.out2 -p $x.prm -c $x-$lam.mdrest1 -r $x-$lam.mdrest2 -ref $x.rst
srun --cpu_bind=rank -n $PROCESSORS pmemd.MPI -O -i  $x-$lam-sander.in3 -o $x-$lam-sander.out3 -p $x.prm -c $x-$lam.mdrest2 -r $x-$lam.mdrest3
srun --cpu_bind=rank -n $PROCESSORS pmemd.MPI -O -i  $x-$lam-sander.in4 -o $x-$lam-sander.out4 -p $x.prm -c $x-$lam.mdrest3 -r $x-$lam.mdrest4 -x $x-$lam.mdcrd4

EOF


if ! [[ "$lam" = "0.000" && "$x" = "prot" ]] ; then
    echo "sbatch q-$x-$lam" >> sub2.bash
fi

echo "sbatch q-$x-$lam" >> sub-all.bash


done
#end_of_prot_wat_loop 
done 
#end of lambda-loop

############## END NOTES #########################################
echo "------kebmakefep---v2----"
echo "13 lambda" 
date
echo "-----------------------------"
echo "Script used: $0"
echo "For testing FEP simulation:"
echo "bash sub1-test.bash"
echo 
echo "----------------------------"


