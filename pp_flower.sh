#!/bin/bash

file=times-$(hostname)-pp.txt
echo "" > $file
output=out-$(hostname)-pp.txt
echo "" > $output
TIME="/usr/bin/time -ao $file -v"
set -x
$TIME ./savu_mpi_local.sh /home/dt1107582/flower/ flower_pp.nxs out >> $output 2>&1
# savu out

set +x



