# nf-mod-bedtools

Nextflow module for bedtools + ucsc-bedGraphToBigWig. Used as a git submodule by pipelines.

Image: `ghcr.io/eit-gbi/nf-mod-bedtools:latest`

## :gear: Processes

- `BIGWIG` ([bigwig/main.nf](bigwig/main.nf)) — inputs: `tuple(sample, label, bam, bai)` + `val chrom_sizes` → output: `path ${sample}.${label}.bw` (optional)

Generates a coverage bigWig from an indexed BAM via `bedtools genomecov -bg` piped into `bedGraphToBigWig`. The intermediate bedGraph stays inside the Nextflow work dir — only the final bigWig is published. Empty-coverage samples are skipped.

## :hammer_and_wrench: Use as submodule
```bash
git submodule add https://github.com/eit-gbi/nf-mod-bedtools.git modules/bedtools
```

Then in your pipeline:
```
include { BIGWIG } from './modules/bedtools/bigwig/main.nf'
```
