#!/bin/bash

file=times-$(hostname)-recon-mpi.txt
echo "" > $file
output=out-$(hostname)-recon-mpi.txt
echo "" > $output
TIME="/usr/bin/time -ao $file -v"
set -x
$TIME ./savu_mpi_local.sh out/2*/flower_processed.nxs flower_recon.nxs out >> $output 2>&1
$TIME ./savu_mpi_local.sh out/2*/flower_processed.nxs flower_recon-10it.nxs out >> $output 2>&1

# savu out

set +x

grep -e "Command" -e "Elapsed" $file
