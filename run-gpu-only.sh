#!/bin/bash
file=times-$(hostname)-gpu-only.txt
echo "" > $file
output=out-$(hostname)-gpu-only.txt
echo "" > $output
TIME="/usr/bin/time -ao $file -v"
set -x

pls="gpu_rec gpu_rec_10it gpu_rec_50it gpu_rec_100it gpu_rec_200it gpu_rec_300it gpu_rec_500it gpu_rec_700it gpu_rec_1000it"

for pl in $pls; do
    $TIME savu 24737.nxs $pl out/ >> $output 2>&1
    echo ====== >> $file
    $TIME ./savu_mpi_local.sh 24737.nxs $pl out/ >> $output 2>&1
done

set +x

grep -e "Command" -e "Elapsed" $file 
