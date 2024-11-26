# Outputs of the FIRE pipeline

The FIRE pipeline returns outputs for a sample in the directory `results/{sample}/` and files are labeled with the sample (`{sample}`) and the version of the FIRE pipeline (`{v}`). The following files and directories are generated:

| Output                                   | Description                                                                                        |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------- |
| {sample}-fire-{v}-filtered.cram          | CRAM file containing the all the data used in the FIRE pipeline.                                   |
| {sample}-fire-{v}-peaks.bed.gz           | BED file containing the FIRE peaks calls                                                           |
| {sample}-fire-{v}-hap-differences.bed.gz | BED file containing the results of searching for haplotype-selective peaks.                        |
| {sample}-fire-{v}-pileup.bed.gz          | BED file containing per-base information on number of FIREs, MSPs, nucleosomes, coverage and more. |
| {sample}-fire-{v}-qc.tbl.gz              | Table containing quality control metrics for the FIRE CRAM.                                        |
| trackHub-{v}/                            | Directory containing a UCSC trackHub for visualizing all the results of the FIRE pipeline.         |
| additional-outputs-{v}/                  | Directory containing additional outputs from the FIRE pipeline.                                    |

# More details on the individual outputs

## The `{sample}-fire-{v}-filtered.cram` file

The CRAM file contains all the data used in the FIRE pipeline. It is a CRAM file that can be viewed with IGV or other genome browsers. Sequencing quality scores are removed from the CRAM file to reduce the file size since per base quality scores are not used in the FIRE pipeline, as well as reads with insufficient m6A signal. The CRAM file is sorted and indexed.

## The `{sample}-fire-{v}-peaks.bed.gz` file

This is the peak file for the FIRE method. Peaks are called by identifying FIRE score ([methods](methods/aggregation.md)) local-maxima that have FDR values below a threshold. By default, the pipeline reports peaks at a 5% FDR threshold. Once a local-maxima is identified, the start and end positions of the peak are determined by the median start and end positions of the underlying FIRE elements. We also calculate and report wide peaks in the `additional-outputs/` by taking the union of the FIRE peaks and all regions below the FDR threshold and then merging resulting regions that are within one nucleosome (147 bp) of one another.

The FIRE peaks file has the following columns:
| Column | Description |
| --- | --- |
| #chrom | Chromosome of the peak |
| peak\*start | Start of the peak |
| peak_end | End of the peak |
| start | Start of the maximum of the peak |
| end | End of the maximum of the peak |
| coverage | Coverage of the peak |
| fire_coverage | Coverage of the FIREs in the peak |
| score | FIRE score of the peak (see [methods](methods/aggregation.md)) |
| nuc_coverage | Coverage of the nucleosomes in the peak |
| msp_coverage | Coverage of the MSPs in the peak |
| .\*\*{H1,H2} | Repeats of previous columns but specific for the two haplotypes |
| FDR | False discovery rate of the peak |
| log_FDR | -10\*log10 of the FDR |
| FIRE_size_mean | Mean size of the FIREs in the peak |
| FIRE_size_ssd | Standard deviation of the size of the FIREs in the peak |
| FIRE_start_ssd | Standard deviation of the start of the FIREs in the peak |
| FIRE_end_ssd | Standard deviation of the end of the FIREs in the peak |
| pass_coverage | Whether the peak passes coverage filters |

## The `{sample}-fire-{v}-hap-differences.bed.gz` file

This file primarily contains the same columns as the FIRE peaks file but additionally has a `p_value` column with the results of a Fisher's exact test for the difference in coverage between the two haplotypes, and a `p_adjust` column with the Benjamini-Hochberg adjusted p-value. See the [methods](methods/haplotype-selective.md) for more details.

## The `{sample}-fire-{v}-pileup.bed.gz` file

This is a BED file containing per-base information on number of FIREs, MSPs, nucleosomes, coverage and more. The columns are calculated using `ft-pileup` and more details can be found in the `ft-pileup` documentation.

## The `{sample}-fire-{v}-qc.tbl.gz` file

This file contains quality control metrics for the FIRE CRAM. The results are directly created by `ft-qc` and more details can be found in the `ft-qc` documentation.

## The `trackHub-{v}/` directory

The `trackHub-{v}/` directory contains a UCSC trackHub for visualizing all the results of the FIRE pipeline. A description of the trackHub can be found in `trackHub/fire-description.html`. The trackHub can be loaded into UCSC by uploading the trackHub directory to a public facing website and then loading the `hub.txt`'s URL into the UCSC trackHub browser.

A copy of the trackHub description can be found [here](https://s3-us-west-2.amazonaws.com/stergachis-public1/Mitchell/temp/FIRE/dev/trackHub/fire-description.html).

## The `additional-outputs-{v}/` directory

The `additional-outputs-{v}/` directory contains the following files:
TODO
