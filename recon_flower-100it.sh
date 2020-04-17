#!/bin/bash

file=times-$(hostname)-recon-100it.txt
echo "" > $file
output=out-$(hostname)-recon-100it.txt
echo "" > $output
TIME="/usr/bin/time -ao $file -v"
set -x
$TIME savu out/2*/flower_processed.nxs flower_recon-100it.nxs out >> $output 2>&1

# savu out

set +x

grep -e "Command" -e "Elapsed" $file
