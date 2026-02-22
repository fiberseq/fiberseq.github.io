# Installation and usage

## Install

```bash
pip install fiberhmm
```

Or from source:

```bash
git clone https://github.com/fiberseq/FiberHMM.git
cd FiberHMM
pip install -e .
```

Optional: install `numba` for ~10x faster HMM computation, and `matplotlib` for `--stats` diagnostic plots.

```bash
pip install numba matplotlib
```

## Pipeline overview

FiberHMM has four main steps, each with a dedicated command:

1. **Generate emission probabilities** from control data (`fiberhmm-probs`)
2. **Train the HMM** on your sample (`fiberhmm-train`)
3. **Call footprints** on your experiment (`fiberhmm-apply`)
4. **Extract to BED12/bigBed** for visualization (`fiberhmm-extract`)

If you already have a [pre-trained model](models.md) for your chemistry, you can skip directly to step 3.

## Generating emission probabilities

This requires two control BAMs: one with accessible (naked/dechromatinized) DNA and one with inaccessible (native chromatin) DNA. These define how methylation rates differ between accessible and inaccessible states for each sequence context.

```bash
fiberhmm-probs \
    -a accessible_control.bam \
    -u inaccessible_control.bam \
    -o probs/ \
    --mode pacbio-fiber \
    --stats
```

This produces emission probability tables in `probs/tables/` for each context size.

## Training the HMM

```bash
fiberhmm-train \
    -i sample.bam \
    -p probs/tables/accessible_A_k3.tsv probs/tables/inaccessible_A_k3.tsv \
    -o models/ \
    -k 3 \
    --stats
```

Output: `models/best-model.json` (the trained model).

## Calling footprints

```bash
fiberhmm-apply \
    -i experiment.bam \
    -m models/best-model.json \
    -o output/ \
    -c 8 \
    --scores
```

This writes a BAM file with fibertools-compatible footprint tags:

| Tag | Type | Description |
|-----|------|-------------|
| `ns` | B,I | Footprint starts (0-based query coords) |
| `nl` | B,I | Footprint lengths |
| `as` | B,I | MSP starts |
| `al` | B,I | MSP lengths |
| `nq` | B,C | Footprint quality scores (0-255, with `--scores`) |
| `aq` | B,C | MSP quality scores (0-255, with `--scores`) |

The output BAM is compatible with `ft extract`, FIRE, and any other tool that reads fibertools-style tags.

## Extracting to BED12/bigBed

```bash
fiberhmm-extract -i output/experiment_footprints.bam
```

This produces bigBed files for footprints, MSPs, m6A, and m5C that can be loaded into genome browsers.

## Analysis modes

| Mode | Flag | Chemistry | Target bases |
|------|------|-----------|--------------|
| **PacBio fiber-seq** | `--mode pacbio-fiber` | Hia5 m6A, both strands | A, T (with RC) |
| **Nanopore fiber-seq** | `--mode nanopore-fiber` | Hia5 m6A, single strand | A only |
| **DAF-seq** | `--mode daf` | DddA/DddB deamination | C or G |

The `pacbio-fiber` vs `nanopore-fiber` distinction only matters for Hia5, where PacBio detects modifications on both strands while Nanopore detects only one. For deaminase-based methods (DddA, DddB), `--mode daf` is always used regardless of sequencing platform.

## Utilities

`fiberhmm-utils` provides additional commands for model management:

```bash
# Convert legacy models to JSON
fiberhmm-utils convert old_model.pickle new_model.json

# Inspect model parameters
fiberhmm-utils inspect model.json

# Transfer emission probs between chemistries
fiberhmm-utils transfer --target daf.bam --reference-bam fiber.bam -o probs/ --mode daf

# Scale emission probabilities
fiberhmm-utils adjust model.json --state accessible --scale 1.1 -o adjusted.json
```

## Performance tips

- Use `-c 8` (or more cores) for parallel footprint calling
- For small genomes, reduce `--region-size` (500KB for yeast, 2MB for Drosophila)
- Install `numba` for faster HMM training
- Use `--skip-scaffolds` to avoid processing thousands of contigs
