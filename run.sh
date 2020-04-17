#!/bin/bash
file=times-$(hostname).txt
echo "" > $file
output=out-$(hostname).txt
echo "" > $output
set -x

pls="cpu_rec cpu_rec_10it cpu_rec_50it cpu_rec_100it gpu_rec gpu_rec_10it gpu_rec_50it gpu_rec_100it"

for pl in $pls; do
    TIME="/usr/bin/time -ao $file -v"
    $TIME savu 24737.nxs $pl out/ >> $output 2>&1
    echo ====== >> $file
    $TIME ./savu_mpi_local.sh 24737.nxs $pl out/ >> $output 2>&1
done

set +x

grep -e "Command" -e "Elapsed" $file
