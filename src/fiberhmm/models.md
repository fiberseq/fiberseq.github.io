# Pre-trained models

FiberHMM ships with pre-trained models in the `models/` directory. These can be used directly with `fiberhmm-apply` without needing to generate emission probabilities or train from scratch.

## Available models

| Model | File | Enzyme | Platform | Mode | Organism |
|-------|------|--------|----------|------|----------|
| **Hia5 PacBio** | `hia5_pacbio.json` | Hia5 (m6A) | PacBio | `pacbio-fiber` | Drosophila |
| **Hia5 Nanopore** | `hia5_nanopore.json` | Hia5 (m6A) | Nanopore | `nanopore-fiber` | Yeast |
| **DddA PacBio** | `ddda_pacbio.json` | DddA (deamination) | PacBio | `daf` | Drosophila |
| **DddB Nanopore** | `dddb_nanopore.json` | DddB (deamination) | Nanopore | `daf` | Drosophila |

## Using a pre-trained model

```bash
# PacBio Hia5 fiber-seq
fiberhmm-apply -i experiment.bam -m models/hia5_pacbio.json -o output/ -c 8

# Nanopore Hia5 fiber-seq
fiberhmm-apply -i experiment.bam -m models/hia5_nanopore.json -o output/ -c 8

# DAF-seq (DddA or DddB)
fiberhmm-apply -i experiment.bam -m models/ddda_pacbio.json -o output/ -c 8 --mode daf
```

The mode and context size are stored in the model JSON and auto-detected at runtime, so you generally do not need to specify `--mode` or `-k` when using a pre-trained model.

## When to train your own model

The pre-trained models work well as a starting point, but you may want to train a custom model if:

- You are working with a different organism where chromatin structure differs substantially
- You are using a different methyltransferase or deaminase chemistry
- You have matched accessible and inaccessible controls for your specific experiment

See the [usage guide](usage.md) for the full training pipeline.

## Inspecting a model

You can inspect any model's parameters with:

```bash
fiberhmm-utils inspect models/hia5_pacbio.json
```

This prints the mode, context size, start probabilities, transition matrix, and emission probability summary statistics.
