#!/bin/bash

file=times-$(hostname)-recon.txt
echo "" > $file
output=out-$(hostname)-recon.txt
echo "" > $output
TIME="/usr/bin/time -ao $file -v"
set -x
$TIME savu out/2*/flower_processed.nxs flower_recon.nxs out >> $output 2>&1
# savu out

set +x

grep -e "Command" -e "Elapsed" $file
