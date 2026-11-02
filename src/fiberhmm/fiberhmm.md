# FiberHMM: chromatin footprint calling

[![GitHub](https://img.shields.io/github/v/release/fiberseq/FiberHMM?color=green)](https://github.com/fiberseq/FiberHMM)
[![PyPI](https://img.shields.io/pypi/v/fiberhmm)](https://pypi.org/project/fiberhmm/)

FiberHMM calls chromatin footprints on single molecules from Fiber-seq (m6A,
Hia5) and DAF-seq (deamination, DddA and DddB) data, on PacBio and Oxford
Nanopore reads. For each read it finds nucleosomes, transcription-factor and
other sub-nucleosomal footprints, and the methylase-sensitive patches (MSPs)
between them. It writes every call, TF footprints included, as
[Molecular-annotation](https://github.com/fiberseq/Molecular-annotation-spec)
`MA`/`AQ` tags (`nuc`, `msp` and `tf` groups, with per-call quality bytes), and
keeps nucleosomes and MSPs in the fibertools `ns`/`nl` and `as`/`al` tags for
older tools. `ft`, FIRE and FiberBrowser read them.

Its emission probabilities are learned per sequence context, which corrects
the large context bias of the marking enzymes and makes footprints the size
of a transcription factor callable, not just nucleosomes. Across molecules,
FiberHMM also finds recurrent footprint classes at a locus and measures how
often each molecule carries them.

This chapter is a short overview:

- [Installation and usage](usage.md)
- [Pre-trained models](models.md)
- [How it works](methods.md)

The current release is FiberHMM 3.0.2. To look at its footprints molecule by
molecule, use [FiberBrowser](../fiberbrowser/fiberbrowser.md). FiberHMM and
FiberBrowser are described in our
[bioRxiv preprint](https://www.biorxiv.org/content/10.64898/2026.10.29.762797v1);
see [Cite](../cite.md).

The full documentation is at
[fiberseq.github.io/FiberHMM](https://fiberseq.github.io/FiberHMM/); the
source is on [GitHub](https://github.com/fiberseq/FiberHMM).

> **FiberHMM 3.0** ships updated Nanopore Hia5 and DddB emission tables.
> Re-run calls made with earlier versions; `fiberhmm-check <your outputs>`
> lists which files need it
> ([upgrading from 2.x](https://fiberseq.github.io/FiberHMM/upgrading/)).
