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


## The {sample}.cram file


## The {sample}-fire-peaks.bed.gz file
The FIRE peaks file has the following columns:
| Column | Description |
| --- | --- |
| #chrom | Chromosome of the peak |
| peak_start | Start of the peak |
| peak_end | End of the peak |
| start | Start of the maximum of the peak |
| end | End of the maximum of the peak |
| coverage | Coverage of the peak |
| fire_coverage | Coverage of the FIREs in the peak |
| score | FIRE score of the peak (see ) |
| nuc_coverage | Coverage of the nucleosomes in the peak |
| msp_coverage | Coverage of the MSPs in the peak |
| .*_{H1,H2} | Repeats of previous columns but specific for the two haplotypes |
| FDR | False discovery rate of the peak |
| log_FDR | -10*log10 of the FDR |
| FIRE_size_mean | Mean size of the FIREs in the peak |
| FIRE_size_ssd | Standard deviation of the size of the FIREs in the peak |
| FIRE_start_ssd | Standard deviation of the start of the FIREs in the peak |
| FIRE_end_ssd | Standard deviation of the end of the FIREs in the peak |
| pass_coverage | Whether the peak passes coverage filters |

# The {sample}-hap-differences.bed.gz file
This file primarily contains the same columns as the FIRE peaks file but additionally has a `p_value` column with the results of a Fisher's exact test for the difference in coverage between the two haplotypes, and a `p_adjust` column with the Benjamini-Hochberg adjusted p-value.

## The trackHub directory
The `trackHub/` directory contains a UCSC trackHub for visualizing all the results of the FIRE pipeline. A description of the trackHub can be found in `trackHub/fire-description.html`. The trackHub can be loaded into UCSC by uploading the trackHub directory to a public facing website and then loading the `hub.txt`'s URL into the UCSC trackHub browser.

## The additional-outputs directory
The `additional-outputs/` directory contains the following files: