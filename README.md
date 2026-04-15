# Image Enhancement in the Spatial Domain

MATLAB implementations of classical spatial-domain image enhancement operations. The scripts intentionally implement several operations manually to make the pixel-level processing steps explicit.

## Contents

- `histogram_thresholding.m`: computes an image histogram manually and applies threshold-based binary enhancement.
- `median_filter_sobel_edges.m`: applies a 3x3 median filter for salt-and-pepper noise and compares Sobel edge maps before and after filtering.
- `min_max_morphological_filter.m`: applies max and min filtering as a basic morphology-inspired cleanup pipeline.

## Techniques

- Manual histogram computation
- Thresholding and binary enhancement
- Pixel-replication padding
- Median filtering
- Min/max filtering
- Sobel edge detection

## Files

- `threshold_input.png`
- `salt_pepper_noise_input.png`
- `morphology_input.png`

## Run

Open MATLAB in this folder and run any script directly, for example:

```matlab
run('median_filter_sobel_edges.m')
```
