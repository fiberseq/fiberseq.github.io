# The Fiber-seq BAM format

The Fiber-seq BAM format adds to m6A BAM data from a PacBio (`ft predict-m6a`) or ONT (`dorado`) sequencing run with m6A.

The following tags are added to the BAM file:

- `ns:B:I,`: Nucleosome start sites (0-based) on the forward strand of the sequencing read (u32).
- `nl:B:I,`: Equal length array to `ns` of nucleosome lengths (u32).
- `as:B:I,`: MSP start sites (0-based) on the forward strand of the sequencing read (u32).
- `al:B:I,`: Equal length array to `as` of MSP lengths (u32).
- `aq:B:C,`: Quality scores for the MSPs [0, 255] (u8).

