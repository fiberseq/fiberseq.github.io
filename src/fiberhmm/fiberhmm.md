# FiberHMM: HMM-based chromatin footprint calling

[![GitHub](https://img.shields.io/github/v/release/fiberseq/FiberHMM?color=green)](https://github.com/fiberseq/FiberHMM)
[![PyPI](https://img.shields.io/pypi/v/fiberhmm)](https://pypi.org/project/fiberhmm/)

FiberHMM is a hidden Markov model toolkit for calling chromatin footprints and methylase-sensitive patches (MSPs) from single-molecule data. It works with Fiber-seq (m6A via Hia5) and DAF-seq (deamination via DddA/DddB), producing fibertools-compatible BAM output with `ns`/`nl`/`as`/`al` tags.

By learning sequence-context-specific emission probabilities from control data, FiberHMM accounts for the large biases in methylation efficiency across different hexamer contexts. This is what enables accurate footprint calling at much smaller sizes than heuristic approaches -- resolving not just nucleosomes but also transcription factor binding sites, Pol II, and other sub-nucleosomal footprints that would otherwise be lost in context noise.

FiberHMM also provides a unified framework for calling footprints across different single-molecule chemistries (Hia5, DddA, DddB) and sequencing platforms (PacBio, Nanopore), making it straightforward to directly compare chromatin accessibility measurements between experiments.

This chapter covers:

- [Installation and usage](usage.md)
- [Pre-trained models](models.md)
- [How it works](methods.md)

The source code and full documentation can be found on [GitHub](https://github.com/fiberseq/FiberHMM).
