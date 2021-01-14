# Benchmark description
The goal of this benchmark is to measure the difference in reconstruction execution time on different hardware.

The benchmark was performed using Savu 2.4 and the AstraReconGpu plugin. It uses the `SIRT_CUDA` reconstruction algorithm
with a varying number of iterations.

Two datasets were used - a small one (~9MB in `uint16`, about ~18MB in `float32`),
and a larger one (~9GB in `uint16`, about ~18GB in `float32`).

The benchmark also includes the time it takes to load and save the data. Due to the varying IO hardware this introduces noise.
As the number of iterations is increased, the IO noise will decrease in significance, as more time is spent processing the data.

# GPU hardware

No overclocking was performed on any of the GPUs.

Nvidia GTX1070 [Specifications](https://www.techpowerup.com/gpu-specs/geforce-gtx-1070.c2840)
 - 1506 MHz base | 1683 MHz boost clock
 - 8008 MHz memory clock
 - 256.3 GB/s
 - 6.463 TFLOPS FP32 (float) performance

Nvidia Quadro P2000 [Specifications](https://www.techpowerup.com/gpu-specs/quadro-p2000.c2931)
 - *0.5x* clock speed to GTX 1070
 - 1076MHz base / 1480 MHz boost clock, *0.71x* base / *0.88x* boost to GTX 1070
 - 7008 MHz memory clock, *0.86x* to GTX 1070
 - 140 GB/s memory transfer, *0.55x* to GTX 1070
 - 3.031 TFLOPS FP32 (float) performance, *0.47x*  to GTX 1070


Nvidia GTX1080Ti [Specifications](https://www.techpowerup.com/gpu-specs/geforce-gtx-1080-ti.c2877)
 - **1.5x** clock speed to GTX 1070
 - 1481 MHz base / 1582 MHz boost clock, _0.98x_ base / _0.94x_ boost to GTX 1070
 - 11008 MHz memory clock, **1.38x** to GTX 1070
 - 484.4 GB/s memory transfer, **1.9x** to GTX 1070
 - 11.34 TFLOPS FP32 (float) performance, **1.77x** to GTX 1070

# Machines used
## Machine 1
2x Nvidia Quadro P2000, no SLI

32GB RAM

Read/write from/to SSD

## Machine 2
Nvidia GTX 1070

90GB RAM

10Gbps network storage
## Machine 3
Nvidia GTX 1080Ti

128GB RAM

Read from HDD, write to SSD

# Results
The time measured is the total amount of time (wall clock) the process took. This is the real time the user has to wait from launching the command to getting the output.

For identifying the machines the GPU model is used.

The times displayed are in format `h:mm:ss` or `m:ss.ms`.
## Small dataset
| Iterations | GTX 1070 | GTX 1080Ti |
|--------|--------|--------|
|1|0:01.18|0:01.25|
|10|0:01.61|0:01.36|
|50|0:03.73|0:03.21|
|100|0:06.35|0:05.17|
|200|0:11.56|0:09.54|
|300|0:17.05|0:12.49|
|500|0:27.44|0:21.10|
|700|0:37.75|0:28.70|
|1000|0:53.94|0:39.78|

Using GTX 1070 as the base this gives the following relative speed-up

| Iterations | GTX 1070 | GTX 1080Ti |
|--------|--------|--------|
|1|1x|0.944x|
|10|1x|1.183x|
|50|1x|1.162x|
|100|1x|1.228x|
|200|1x|1.212x|
|300|1x|1.365x|
|500|1x|1.300x|
|700|1x|1.315x|
|1000|1x|1.355x|
## Discussion
<!-- it is worth considering that the size of a reconstruction for
determining the determining the center of rotation of a bigger dataset -->
The speed benefits of the GTX 1080Ti can be immediatelly seen, even with small datasets.
The total time is not unreasonably long for a small dataset,
however, it is worth considering that the GTX 1080Ti will make
for a faster workflow when determining the
center of rotation of a bigger dataset, as a couple of sinograms will
be approximately the size of the small dataset.

The GTX 1080Ti performs better as the iterations, and consequently processing time,
is increased. This will become much more apparent in the Large dataset processing.

## Large dataset
| Iterations | 2 x Quadro P2000 | GTX 1070 | GTX 1080Ti |
|--------|--------|--------|----|
|1|20:17.80|16:13.98|7:14.29|
|10|47:38.56|34:58.87|19:57.40|
|100|5:30:00 (estimated)|4:07:52|2:03:53|

Using GTX 1070 as the base this gives the following relative speed-up

| Iterations | 2 x Quadro P2000 | GTX 1070 | GTX 1080Ti |
|--------|--------|--------|----|
|1|0.8x|1x|2.242x|
|10|0.734x|1x|1.753x|
|100|0.75x (estimated)|1x|2x|

## Discussion
### Quadro P2000
This GPU is seemingly faster than the specifications would lead to believe, however
it must be remembered that the machine had **2** of them doing the processing
simultaneously. This has increased the expected speed against GTX 1070 of `0.5x` to the
measured one `0.7 - 0.8x`. These results indicate that, for this workflow,
two half-as-good GPUs might not be equally performant as a single more powerful GPU.

Due to the fact that the P2000 **does not support** an SLI bridge, the software was
treating them as two separate GPUs. It is possible that having a SLI bridge would
increase the performance.

### GTX 1080Ti
As expected the 1080Ti has the fastest processing times. 

When comparing the specifications of the clock speed, the expected speed-up would be `1.5x`. The real measurements show a much higher performance increase of `~1.75 - 2.2x`
The reason for that is believed to be the significantly improved memory specifications of the GTX 1080Ti.

## Conclusion
From these benchmarks it can be seen that the clock speed, usually shown in online benchmarking websites,
is not guaranteed to be accurate for this use case. It was found that looking at the
`Float 32 TFLOPS` performance is a more accurate indicator of real world performance, as the
difference between the cards on that specification are much closer to the measured performance.


## Future questions
- Would SLI net a higher improvement for multiple GPUs?
- Benchmarking 2 GTX 1070s and compare against the GTX 1080Ti
  - The difference in performance between the 1070 and the 1080Ti are similar as between the P2000 and the 1070.
- Expending the benchmark to include newer GPUs
