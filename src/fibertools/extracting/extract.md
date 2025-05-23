# `ft extract`

Extract Fiber-seq data into plain text files

## Inputs and options

See the [help message](../help.md#ft-extract) for details.

## Output description

All outputs to `ft extract` can be (and should be) compressed by simply adding the `.gz` extension.
For example, `ft extract input.bam --m6a m6a.bed.gz` will output a compressed bed12 file. Use `-` to output to `stdout`, e.g. `ft extract input.bam --m6a -`.

### Shared Output columns:

| Column | Description                                     |
| ------ | ----------------------------------------------- |
| ct     | Chromosome or contig                            |
| st     | Start position of the read on the chromosome    |
| en     | End position of the read on the chromosome      |
| fiber  | The fiber/read name                             |
| score  | The number of ccs passes for the read (rounded) |
| strand | The strand of the read alignment                |

### Columns specific to the `--m6a`, `--cpg`, `--nuc`, and `--msp` outputs

All of these files are written in standard bed12 format. The first and last block in each the bed12 record do not reflect real data, and exist only to mark the start and end positions of the read. If you would like to convert these beds into bigBeds be sure to include `-allow1bpOverlap` in your command.

| Column      | Description                                                                              |
| ----------- | ---------------------------------------------------------------------------------------- |
| thick start | Same as the start (`st`)                                                                 |
| thick end   | Same as the end (`en`)                                                                   |
| itemRgb     | Color specifc to the datatype, e.g. m6a marks get a purple RGB                           |
| blockCount  | The number of blocks in the bed12 record                                                 |
| blockSizes  | A comma separated list of the lengths of each feature in the bed12 record                |
| blockStarts | A comma separated list of the relative start positions of each block in the bed12 record |

### Columns specific to the `--all` output

| Column          | Description                                                                                                                                     |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| sam_flag        | The sam flag of the read alignment                                                                                                              |
| HP              | The haplotype tag for the read                                                                                                                  |
| RG              | The read group tag for the read                                                                                                                 |
| fiber_length    | The length of the read in bp                                                                                                                    |
| fiber_sequence  | The sequence of the read                                                                                                                        |
| ec              | The number of ccs passes for the read (no rounding)                                                                                             |
| rq              | The estimated accuracy of the read                                                                                                              |
| total_AT_bp     | The total number of AT bp in the read                                                                                                           |
| total_m6a_bp    | The total number of m6a bp in the read                                                                                                          |
| total_nuc_bp    | The total number of nucleosome bp in the read                                                                                                   |
| total_msp_bp    | The total number of MSP bp in the read                                                                                                          |
| total_5mC_bp    | The total number of 5mC bp in the read                                                                                                          |
| nuc_starts      | The start positions of the nucleosomes in molecular coordinates (comma separated list)                                                          |
| nuc_lengths     | The lengths of the nucleosomes in molecular coordinates (comma separated list)                                                                  |
| ref_nuc_starts  | The start positions of the nucleosomes in reference coordinates (comma separated list)                                                          |
| ref_nuc_lengths | The lengths of the nucleosomes in reference coordinates (comma separated list)                                                                  |
| msp_starts      | The start positions of the MSPs in molecular coordinates (comma separated list)                                                                 |
| msp_lengths     | The lengths of the MSPs in molecular coordinates (comma separated list)                                                                         |
| fire            | The quality score of the MSP as a FIRE element (if FIRE as been applied). Scores over 230 are FIRE elements (comma separated list, range 0-255) |
| ref_msp_starts  | The start positions of the MSPs in reference coordinates (comma separated list)                                                                 |
| ref_msp_lengths | The lengths of the MSPs in reference coordinates (comma separated list)                                                                         |
| m6a             | The start positions of the m6a in molecular coordinates (comma separated list)                                                                  |
| ref_m6a         | The start positions of the m6a in reference coordinates (comma separated list)                                                                  |
| m6a_qual        | The quality of the m6a positions (ML value, comma separated list)                                                                               |
| 5mC             | The start positions of the 5mC in molecular coordinates (comma separated list)                                                                  |
| ref_5mC         | The start positions of the 5mC in reference coordinates (comma separated list)                                                                  |
| 5mC_qual        | The quality of the 5mC positions (ML value, comma separated list)                                                                               |

Note positions in columns starting with `ref_` maybe contain `-1` (NA) values if the reference sequence has an insertion or deletion relative to the read sequence at that position.
