#!/bin/bash
#SBATCH -c 1
#SBATCH -t 48:00:00
#SBATCH -A SNIC2016-34-18
#SBATCH -J freq-tor

module add intel
export AMBERHOME=/common/sw/alarik/pkg/bio/AMBER/Amber14
export TURBODIR=/common/sw/alarik/pkg/bio/TURBO/Turbo6.6
export CNS_SOLVE=/common/sw/alarik/pkg/bio/CNS/cns_solve_1.21
PATH=$PATH:/common/sw/alarik/pkg/bio/Bin:$HOME/Bin:/common/sw/alarik/pkg/bio/Pon_param/
PATH=$TURBODIR/scripts:$TURBODIR/bin/x86_64-unknown-linux-gnu:$PATH
PATH=$AMBERHOME/bin:$PATH
export PATH

cd $SNIC_TMP

cp -p $SLURM_SUBMIT_DIR/* .

#############################################################################

jobex -c 200
turbofreq
aoforce > $SLURM_SUBMIT_DIR/logf

cp -pu * $SLURM_SUBMIT_DIR

##############################################################################


