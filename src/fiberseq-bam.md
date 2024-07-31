# The Fiber-seq BAM format

The Fiber-seq BAM format adds to m6A BAM data from a PacBio (`ft predict-m6a`) or ONT (`dorado`) sequencing run with m6A.

The following tags are added to the BAM file:

- `ns:B:I,`: Nucleosome start sites (0-based) on the forward strand of the sequencing read (u32).
- `nl:B:I,`: Equal length array to `ns` of nucleosome lengths (u32).
- `as:B:I,`: MSP start sites (0-based) on the forward strand of the sequencing read (u32).
- `al:B:I,`: Equal length array to `as` of MSP lengths (u32).
- `aq:B:C,`: Quality scores for the MSP [0, 255] (u8). This tag is optional and added by `ft fire`.

The `ns` or `as` tag do not need to begin or end at the start or end of the read; however, once begun, they must be contiguous. i.e. the `ns` and `as` tags must combine to form a contiguous set of alternating nucleosome and MSP sites. The `ns`, `nl`, `as`, and `al` tags are added to the BAM file automatically using `ft predict-m6a` or later using the `ft add-nucleosomes` command. 

The `aq` tag is added using the `ft fire` command and represents the estimated precision of the MSP being a [FIRE](glossary.md#fire). Specifically, the estimated precision of a FIRE is the value of the `aq` tag divided by 255.





