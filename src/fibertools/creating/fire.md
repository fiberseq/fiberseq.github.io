# `ft fire`

This command identifies **<ins>F</ins>iber-seq <ins>I</ins>nferred <ins>R</ins>egulatory <ins>E</ins>lements** (FIREs) from a Fiber-seq BAM. The input is a Fiber-seq BAM file with m6A and nucleosome calls and the output is a Fiber-seq bam file with the FIREs encoded in the `aq` tags.

This command can be run in isolation; however, it is usually preferable to run the [FIRE pipeline](https://github.com/fiberseq/FIRE), which runs `ft fire` and performs many additional analyses and visualizations.

[**The help page**](../help.md#ft-fire).

## I just need the FIRE elements

If you only need FIRE elements in the BAM file and don't need the peak-calls or trackHubs that are part of the FIRE pipeline you can do a simplified run FIRE using only `ft`. e.g.:

```bash
# add FIREs to the BAM file
ft fire input.bam fire.bam
# Extract the FIREs from the BAM file into bed format
ft fire --extract fire.bam fire.bed.gz
# if you want the NUC calls and non-FIRE MSPs as well
ft fire --extract --all fire.bam all.bed.gz
```
