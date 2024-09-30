# Outputs of the FIRE pipeline
The FIRE pipeline returns outputs for a sample in the directory `results/{sample}/` and within that directory, the following files and directories are generated:

| Output | Description |
| --- | --- |
| {sample}.cram | CRAM file containing the all the data used in the FIRE pipeline. |
| {sample}-fire-peaks.bed.gz | BED file containing the FIRE peaks calls |
| {sample}-hap-differences.bed.gz | BED file containing the results of searching for haplotype-selective peaks. |
| {sample}-fire-pileup.bed.gz | BED file containing per-base information on number of FIREs, MSPs, nucleosomes, coverage and more. |
| {sample}-fire-elements.bed.gz | BED file containing the individual FIRE elements |
| {sample}-fire-qc.tbl.gz | Table containing quality control metrics for the FIRE CRAM. |
| trackHub/ | Directory containing a UCSC trackHub for visualizing all the results of the FIRE pipeline. |
| additional-outputs/ | Directory containing additional outputs from the FIRE pipeline. |




## the additional-outputs directory
The `additional-outputs/` directory contains the following files:
