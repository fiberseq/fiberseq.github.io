# The quick start guide for analyzing Fiber-seq data

The primary tool for handling Fiber-seq data is `fibertools`, and this page provides a high level order of operations for turning you raw Fiber-seq data into useful chromatin information. The steps differ slightly depending on if you are starting with PacBio or Oxford Nanopore Technologies (ONT); however, the steps can be summarized as:

- Create or filter m6A calls
- Infer nucleosomes and modification sensitive patches (MSPs)
- Apply the Fiber-seq QC tool
- Align and phase the data
- Validate your Fiber-seq BAM file
- Apply Fiber-seq inferred regulatory element (FIRE) calling to identify peaks and create UCSC browser tracks

<!-- toc -->

# Fiber-seq starting with PacBio

<div class="warning">

For using Fiber-seq data it is important to **check with your sequencing provider prior to sequencing** to ensure that the output file will have the required information for Fiber-seq. The provider must select for the instrument to generate m6A calls using `jasmine` on instrument (if using SPQR chemistry or latter) or for the output to include average kinetics information in the CCS BAM (if using earlier chemistries), without this information you will not be able to use your Fiber-seq data.

</div>

## Predict m6A and infer nucleosomes

#### Your PacBio data uses the SPQR chemistry or latter

As of the SPQR chemistry PacBio's base modification caller `jasmine` can make m6A predictions on instrument in addition to 5mC.

This removes the need for `ft predict` and the need to save the kinetics tags within the PacBio BAM. However, after you must still run `ft add-nucleosomes` which is required for downstream analysis.

```bash
ft add-nucleosomes -t 16 input.pacbio.bam output.fiberseq.bam
```

#### Your PacBio data predates the SPQR chemistry

To create useable Fiber-seq data you must first call m6A base-mods on the PacBio CCS bam using `fibertools`. First [install fibertools](fibertools/install.md) and then process your bam file using the prediction command.

```bash
ft predict-m6a -t 16 input.ccs.bam output.fiberseq.bam
```

This will both make m6A calls and identify [nucleosomes](glossary.md#inferred-nucleosome) on each [fiber](glossary.md#fiber-seq-read-or-fiber).

**Note**, the input **CCS bam must have average kinetics** to be able to call m6A.

## Alignment and phasing

We recommend aligning with [pbmm2](https://github.com/PacificBiosciences/pbmm2) and phasing with [HiPhase](https://github.com/PacificBiosciences/hiphase). Please see their respective documentation for more information.

Alternatively, we have written a [snakemake pipeline](https://github.com/mrvollger/k-mer-variant-phasing) to align and phase Fiber-seq data; however, this pipeline is not officially supported outside of our lab at this time.

After this point, you will have a Fiber-seq BAM file that is compatible with all the [extraction](fibertools/extracting/extracting.md) commands in `fibertools`.

## Validate your Fiber-seq BAM file

We have a quick validation tool which can test your BAM file for the desired Fiber-seq features.
At this point you should have m6A calls, nucleosome calls, and aligned reads (phasing is optional).

```bash
ft validate output.fiberseq.bam
Total reads tested: 5000
Fraction with m6A: 100.00%
Fraction with nucleosomes: 100.00%
Number of FIRE calls: 0
Fraction aligned: 100.00%
Fraction phased: 85.10%
Fraction with kinetics: 0.00%
```

## Fiber-seq peaks and UCSC browser tracks (FIRE)

Once you have a phased bam file, you can identify [Fiber-seq inferred regulatory elements (FIREs)](glossary.md#fires) to call Fiber-seq peaks and make a UCSC trackHub.

You can find more details in on installing and running FIRE here:
[Running the FIRE pipeline](/fire/run.md).

# Fiber-seq starting with Oxford Nanopore Technologies (ONT)

## Predict m6A

**ft predict-m6a** does not include a model for ONT data; however, you can use software, such as [Dorado](https://github.com/nanoporetech/dorado), to add CpG and m6A to your ONT BAM file.

## Alignment and phasing

You can either use [Dorado](https://github.com/nanoporetech/dorado) to align your ONT data or use a tool like [minimap2](https://github.com/lh3/minimap2) to align your data. If you do use `minimap2` be sure to include the flag `-y` to preserve the CpG and m6A information in the output BAM file.

If you do want to do phasing we recommend using [WhatsHap](https://whatshap.readthedocs.io/en/latest/) for phasing ONT data. Please see their documentation for more information.

## Filtering m6A calls

If you do use Dorado you must then filter the m6A calls with [modkit](https://github.com/nanoporetech/modkit) using a tenth percentile cutoff for each flow-cell independently. This is the only way to get good m6A calls in our experience, and using any hard ML threshold will not hold between flow-cells. Here is an example command:

```bash
modkit call-mods -t 8 -p 0.1 input.dorado.bam filtered.dorado.bam
```

## Infer nucleosomes and MSPs

Once you have CpG and m6A information in your filtered ONT BAM file, you can use [`ft add-nucleosomes`](fibertools/help.md#ft-add-nucleosomes) to infer nucleosomes and MSPs.

```bash
ft add-nucleosomes  filtered.dorado.bam output.bam
```

## A full example for processing ONT data

Here is an example summary of the commands to process ONT data assuming you have already completed 6mA and CpG calling with `dorado`:

```bash
`#converts to fastq keeping all the BAM tags` \
samtools fastq -@ 8 -T "*" ONT.dorado.with.6mA.bam \
    `#aligns the data inserting the tags back into the output BAM`
    | minimap2 -t 32 --secondary=no -I 8G --eqx --MD -Y -y -ax map-ont reference.fasta - \
    `#optionally add back in the read groups from the original bam using rustybam` \
    | rb add-rg -u ONT.dorado.with.6mA.bam \
    `#sort and index the BAM` \
    | samtools sort -@ 32 --write-index -o tmp.ONT.fiberseq.bam

#filters the ONT data for the best 6mA calls and write to stdout
modkit call-mods -p 0.1 tmp.ONT.fiberseq.bam - \
    `# adds nucleosome calls to the ONT Fiber-seq` \
    | ft add-nucleosomes - ONT.fiberseq.bam
```

After this point, you will have a Fiber-seq BAM file that is compatible with all the [extraction](fibertools/extracting/extracting.md) commands in `fibertools`.

## Fiber-seq peaks and UCSC browser tracks (FIRE)

We have had good success in applying the [FIRE pipeline](https://github.com/fiberseq/FIRE) to ONT data. However, this does require a heuristic in FIRE that must be enabled. To enable this add `ont: true` to your `config.yaml` file when setting up your FIRE run.

You can find more details in on installing and running FIRE here:
[Running the FIRE pipeline](/fire/run.md).
