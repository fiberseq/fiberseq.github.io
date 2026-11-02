# FiberBrowser: a genome browser for single molecules

[![GitHub](https://img.shields.io/github/v/release/fiberseq/FiberBrowser?color=green)](https://github.com/fiberseq/FiberBrowser)
[![PyPI](https://img.shields.io/pypi/v/fiberbrowser)](https://pypi.org/project/fiberbrowser/)

FiberBrowser is an interactive genome browser for Fiber-seq and DAF-seq data at single-molecule resolution. Each row is one DNA molecule, drawn with its nucleosomes, transcription-factor footprints, accessible patches and base modifications. You can cluster, sort and filter molecules by their footprints, measure how often a footprint is occupied and which footprints occur together, split reads by haplotype or structural-variant allele, and export figures and the data behind them.

FiberBrowser shows the footprints called by [FiberHMM](../fiberhmm/fiberhmm.md) and installs it.

## Install

- **Mac app** (Apple silicon, macOS 14+): download the `.dmg` from [Releases](https://github.com/fiberseq/FiberBrowser/releases). It bundles Python, FiberHMM, minimap2 and BLAST+.
- **Windows app** (Windows 10 2004+ or 11): run the `Setup.exe` from [Releases](https://github.com/fiberseq/FiberBrowser/releases).
- **Command line** (macOS, Linux or WSL; Python 3.10+): `pipx install "fiberbrowser[app]"`, then run `fiberbrowser`.

The source code and full documentation are on [GitHub](https://github.com/fiberseq/FiberBrowser): see the [tutorial](https://github.com/fiberseq/FiberBrowser/blob/main/docs/tutorial.md) and the [user guide](https://github.com/fiberseq/FiberBrowser/blob/main/docs/guide.md).

## Cite

FiberBrowser and FiberHMM are described in:

> Tullius, T. W., Catalano, C., Ranchalis, J., Hu, J., Vollger, M. R., Stergachis, A. B., & Levine, M. S. (2026). FiberBrowser: a unified framework for single-molecule genomics. *bioRxiv*. [https://doi.org/10.64898/2026.10.29.762797](https://doi.org/10.64898/2026.10.29.762797)
