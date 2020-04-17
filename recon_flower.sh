#!/bin/bash

file=times-$(hostname)-recon.txt
echo "" > $file
output=out-$(hostname)-recon.txt
echo "" > $output
TIME="/usr/bin/time -ao $file -v"
set -x
$TIME ./savu_mpi_local.sh /mnt/e/Flower_WhiteBeam/ flower_pp.nxs out
# savu out

set +x



