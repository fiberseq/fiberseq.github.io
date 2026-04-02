# How FiberHMM works

## The problem

Single-molecule chromatin assays (Fiber-seq, DAF-seq) mark accessible DNA with enzymatic modifications -- m6A methylation or cytosine deamination. But the efficiency of these enzymes depends on the local sequence context: some hexamers are methylated much more readily than others, even in fully accessible DNA. Without accounting for this, a naive threshold would over-call footprints in low-efficiency contexts and under-call them in high-efficiency ones.

## The approach

FiberHMM uses a two-state hidden Markov model where:

- **State 0 (inaccessible)**: The DNA is nucleosome-protected or otherwise inaccessible. Modification rates are low.
- **State 1 (accessible)**: The DNA is in a methylase-sensitive patch (MSP). Modification rates are high.

The key insight is that emission probabilities are learned per sequence context (hexamer) from control data, so the model knows the expected modification rate for each context in each state. This allows it to correctly interpret a low modification rate at a context that is inherently hard to methylate versus a genuinely protected region.

## Pipeline steps

### 1. Emission probability estimation

Control BAMs define how modification rates differ between accessible and inaccessible states:

- **Accessible control** (e.g., naked DNA treated with methyltransferase): Gives `P(modified | accessible, context)` for each hexamer
- **Inaccessible control** (e.g., native chromatin): Gives `P(modified | inaccessible, context)` for each hexamer

These context-specific emission probabilities are stored as TSV tables, one per context size `k`.

### 2. Training

The Baum-Welch (EM) algorithm learns the transition probabilities and start probabilities from sample data, while the emission probabilities remain fixed from the control data. Multiple random initializations are used to avoid local optima, and the model with the best log-likelihood is selected.

### 3. Decoding

The Viterbi algorithm finds the most likely state sequence for each read. Contiguous runs of state 0 become footprints; contiguous runs of state 1 become MSPs. Optionally, the forward-backward algorithm computes posterior probabilities for per-footprint confidence scores.

## Sequence context encoding

Each position on a read is encoded as a hexamer centered on the target base (for `k=3`, a 7-mer). The hexamer is mapped to an integer code using a deterministic lookup table. For PacBio fiber-seq, reverse complement contexts are merged to account for double-stranded m6A detection. The total number of symbols is `4^(2k)` (or `4^(2k) * 2` with separate modified/unmodified codes).

Context is computed directly from the read sequence -- no genome reference or context files are needed.

## Why context matters for small footprints

Nucleosome-scale footprints (~150 bp) are large enough that context biases average out over the footprint length. But for smaller features -- transcription factor binding sites (~10-30 bp), Pol II (~50 bp) -- individual hexamer biases dominate the signal. A 20 bp stretch of low-efficiency contexts can look identical to a genuine TF footprint if context isn't modeled.

By learning the expected modification rate for each hexamer in each chromatin state, FiberHMM can distinguish true small footprints from context artifacts, enabling accurate sub-nucleosomal footprint calling.
