# Fiber-seq Bench Protocol

From nuclei to sequencing-ready libraries for PacBio HiFi and Oxford Nanopore platforms.

Fiber-seq uses the **Hia5 N6-adenine methyltransferase** to stencil chromatin architecture onto DNA in situ, enabling single-molecule, nucleotide-resolution readout of nucleosome positioning, chromatin accessibility, and transcription factor occupancy on multi-kilobase DNA fibers. This protocol covers the complete workflow from cell line harvest through sequencing-ready libraries for both PacBio HiFi and Oxford Nanopore platforms.

---

## Part 1: Reagents, Buffers, and Equipment

### Buffer A (Fiber-seq Reaction Buffer)

Larger stocks of Buffer A (e.g., 50-100 mL) can be made **without** spermidine, filter sterilized through a 0.22 um filter, and stored at room temperature safely for up to 6 months. Complete Buffer A can then be made by adding 1 uL of 0.5 M spermidine to 999 uL of the Buffer A stock immediately before use (see step 2.5).

| Component              | Stock  | Final    | Per 1 mL |
|------------------------|--------|----------|----------|
| RNase/DNase-free H2O   | 100%   | ---      | 960 uL   |
| Tris-HCl, pH 8.0       | 1 M    | 15 mM    | 15 uL    |
| NaCl                   | 5 M    | 15 mM    | 3 uL     |
| KCl                    | 3 M    | 60 mM    | 20 uL    |
| EDTA, pH 8.0           | 0.5 M  | 1 mM     | 2 uL     |
| EGTA, pH 8.0           | 0.5 M  | 0.5 mM   | 1 uL     |
| Spermidine             | 0.5 M  | 0.5 mM   | 1 uL     |

> **Note:** We generally store 0.5 M spermidine at -20 C for several months. Aliquot into ~20 uL/tube. It is ok to freeze-thaw a few times.

### 2x Lysis Buffer (IGEPAL)

Buffer A supplemented with IGEPAL CA-630 (Sigma I8896) at a cell-type-specific concentration. The 2x stock is diluted 1:1 with the cell suspension during the lysis step. Prepare on ice.

| Cell Line                | Final % IGEPAL | 2x Stock % | uL 10% IGEPAL per 1 mL Buffer A |
|--------------------------|---------------|------------|----------------------------------|
| K562                     | 0.025         | 0.05       | 5 uL                            |
| HEK293                   | 0.025         | 0.05       | 5 uL                            |
| HeLa                     | 0.05          | 0.1        | 10 uL                           |
| HepG2                    | 0.05-0.075    | 0.1-0.15   | 10-15 uL                        |
| LCL (GM12878/GM24385)    | 0.025-0.05    | 0.05-0.1   | 5-10 uL                         |

> **Note:** For the lysis step, you can use either 0.025% or 0.05% final concentration of IGEPAL. Both do a good job isolating nuclei from multiple cell lines with minimal variability between the two concentrations. Generally, use 0.025% for more fragile cells (e.g., HEK293) and 0.05% for more robust ones. For retinal organoids or fibroblasts, Vollger et al. 2025 used 0.2% IGEPAL. For new cell lines, check lysis with trypan blue or AO/PI stain before proceeding.

### Key Reagents

| Reagent | Source | Catalog # | Notes |
|---------|--------|-----------|-------|
| Hia5 N6-adenine MTase | Lab-purified (primary) or EpiCypher CUTANA 15-1032 | --- | FPLC-purified, 100 U/uL, in 10% glycerol, store -80 C |
| SAM, 32 mM | NEB | B9003S | Stored at -20 C. SAM degrades over time; track expiration dates. Avoid excessive freeze-thaw by aliquoting. |
| IGEPAL CA-630 | Sigma-Aldrich | I8896 | NP-40 substitute. When making 10% IGEPAL, it takes time to dissolve. Heating to 37-40 C can help; we sometimes leave it on a rocker overnight. |
| Spermidine | Fisher Scientific | AC132740010 | Resuspend 1 g in 13.76 mL DNase/RNase-free water, filter sterilize with 0.22 um filter. Store 0.5 mL aliquots at -20 C. |
| SDS, 20% solution | Ambion/Invitrogen | AM9820 | For reaction quench |
| Qiagen MagAttract HMW DNA Kit | Qiagen | 67563 | Preferred extraction method |
| Promega Wizard HMW DNA Kit | Promega | A2920 | Alternative extraction method |
| PBS, 1x (no Ca/Mg) | Gibco | 10010023 | For wash and volume adjustment |
| Wide-bore pipette tips | Rainin | various | Essential for all DNA handling |
| DNA LoBind tubes | Eppendorf | 022431021 | 1.5 mL |

### Equipment

- Refrigerated centrifuge (250-700 x g capable)
- Thermocycler with heated lid (25 C and 37 C)
- Qubit 4 fluorometer (Invitrogen)

---

## Part 2: Cell Harvesting and Nuclei Isolation

**Step 2.1 -- Harvest cells.** Collect 1 x 10^6 cells per Fiber-seq reaction. Transfer from culture flask to a 1.5 mL LoBind tube. Pellet at 350 x g for 5 minutes. Remove supernatant completely.

**Step 2.2 -- PBS wash.** Resuspend in 1 mL PBS by gentle pipetting with a wide-bore tip. Pellet again at 350 x g for 5 minutes. Aspirate liquid completely.

**Step 2.3 -- Resuspend in Buffer A.** Gently resuspend the washed cell pellet in 60 uL of Buffer A by gently flicking the tube. Transfer the sample to a PCR tube using a wide-bore tip. Avoid generating bubbles.

> **Tip:** Including 0.1% BSA in the PBS wash can help avoid sticky cell pellets.

**Step 2.4 -- Lysis (nuclei isolation).** Add 60 uL ice-cold 2x Lysis buffer (Buffer A + cell-type-specific IGEPAL; see table above). Gently resuspend using a mild finger flick. Do not vortex or pipette to resuspend. Incubate on ice for 10 minutes. The IGEPAL permeabilizes the plasma membrane while leaving nuclei and chromatin largely intact.

- Optionally, you can get a rough estimate of your lysis efficiency using a cell counter compatible with AO/PI staining. A complete lysis should have a viability count near 0%, with nuclei fluorescing red.

<div class="warning">

**Critical:** The detergent concentration is the single most important variable to optimize for new cell types. We find 0.025-0.05% final IGEPAL works well across most cell lines. If adapting to a new cell type, perform a lysis titration first.

</div>

**Step 2.5 -- Pellet nuclei.** Centrifuge at 350 x g for 5 minutes at 4 C. Carefully remove supernatant. The pellet should appear slightly translucent.

**Step 2.6 -- Resuspend nuclei for methylation reaction.** Resuspend the nuclei pellet in the complete reaction mix (see Part 3 table below). Proceed immediately to the Hia5 treatment.

---

## Part 3: Hia5 Methyltransferase Treatment (In Situ m6A Labeling)

Hia5 is a nonspecific DNA N6-adenine methyltransferase (Drozdz et al., *Nucleic Acids Research* 2012; PMID: 22102579). It methylates adenines in accessible (non-nucleosome-bound) DNA while nucleosome-wrapped DNA is protected, creating a binary methylation stencil of chromatin architecture.

**Step 3.1 -- Resuspend nuclei in reaction mix.** Resuspend the nuclei pellet (from Step 2.5) directly in the complete reaction mix by gentle pipetting:

| Reagent                           | Volume                |
|-----------------------------------|-----------------------|
| Buffer A                          | 57.5 uL              |
| 32 mM SAM (NEB B9003S)           | 1.5 uL               |
| Hia5 MTase (200 U/uL, lab-purified) | 0.5 uL (100 U total) |
| **Total reaction volume**         | **60 uL**             |

If using EpiCypher CUTANA Hia5 instead of lab-purified enzyme, adjust the volume to deliver **200 U total** per million cells based on the lot-specific activity, and adjust the Buffer A volume to maintain 60 uL total.

**Step 3.2 -- Mix and incubate.** Gently flick the tube to resuspend nuclei in the reaction mix. Incubate on a heat block at 25 C for exactly 10 minutes. The 25 C temperature is critical for human cells. Do not exceed 10 minutes, as over-methylation reduces contrast between accessible and nucleosome-protected DNA.

**Step 3.3 -- Quench the reaction.** Add 3 uL of 20% SDS (final ~1% SDS). Gently invert the tube 10 times to mix. SDS denatures Hia5 and halts the reaction instantly.

**Step 3.4 -- Bring to volume for gDNA extraction.** Adjust volume for gDNA extraction per kit requirements. For Promega Wizard, add 37 uL for a final 100 uL and proceed. For Qiagen MagAttract add 117 uL ATL for a final 180 uL (see Part 4).

> **QC Checkpoint 1 -- Reaction parameters:** Record exact incubation time, temperature, and Hia5 lot number/activity. The lab standard is 200 U Hia5 (at 200 U/uL) per million cells. Post-sequencing, the m6A/total adenines ratio should be 0.03-0.09 (median per molecule) or 5-7% globally. Under-methylation yields poor nucleosome resolution; over-methylation erases footprint signal.

---

## Part 4: High Molecular Weight DNA Extraction

After quenching, the sample is a crude lysate of denatured chromatin in SDS. The goal is to extract intact, high molecular weight genomic DNA suitable for long-read sequencing. Bring the lysate volume up to the kit-required input with 1x PBS before proceeding.

### Option A: Qiagen MagAttract HMW DNA Kit (Recommended)

**Step 4A.1 -- Extract with Qiagen MagAttract HMW DNA Kit (cat# 67563).** This bead-based method is the current lab recommendation. It is easier to use than column or precipitation methods and consistently yields more intact DNA. Bring the quenched lysate to 180 uL with ATL buffer, then follow the manufacturer's protocol. The MagAttract beads bind HMW DNA selectively. Elute in 100 uL Buffer AE. Incubate at 4 C overnight or over weekend. If yields are lower than expected, incubate tubes for 5 min at 56 C, shaking at 500 RPM.

> **Note:** The Qiagen MagAttract kit has been much easier than the Promega kit so far, and generally yields more intact DNA. It also works well for primary tissue samples.

### Option B: Promega Wizard HMW DNA Kit

Follow the manufacturer's protocol for the Promega Wizard HMW DNA Extraction Kit (cat# A2920).

### Option C: Nanobind (PacBio) or NEB Monarch (Alternatives)

Other HMW extraction kits may also be used depending on lab availability.

---

## Part 5: PacBio HiFi Library Preparation

This section follows the standard PacBio whole-genome HiFi library workflow using the SMRTbell prep kit 3.0 (PacBio cat# 102-182-700). Fiber-seq DNA is processed identically to standard WGS DNA. This is a PCR-free workflow throughout; amplification must never be used, as it would erase the m6A modifications.

### 5.1 DNA Shearing

Target fragment size: ~15-20 kb (optimal for HiFi CCS reads with >Q30 accuracy).

#### Option A (preferred): Megaruptor 3 (Diagenode)

- Dilute DNA to 83.3 ng/uL (5 ug in 60 uL)
- Run 2-cycle shearing method at speed 31-33

> **QC Checkpoint 3 -- Post-shearing:** Femto Pulse or TapeStation. Mode should be 15-20 kb with minimal material <5 kb or >30 kb. Qubit quantify. Expect ~80% recovery.

#### Option B: Covaris g-TUBE (cat# 520079)

This variation is only recommended for very low input samples or for QC screening of deamination. Median read length will be ~10 kb.

- Load DNA (in 50-150 uL) into the g-TUBE
- For standard applications, follow the [manufacturer's guidelines](https://www.covaris.com/wp/wp-content/uploads/2020/05/pn_010154.pdf)
- For low input (<100 ng), centrifuge in Eppendorf 5424R at 3,200 RPM for 2 minutes. Invert tube and repeat for a total of 4 passes. This step may require optimization depending on input gDNA fragment size, which can be checked by Femto Pulse.
- Recover sheared DNA

**Notes for low input samples:** It is relatively common for a small amount of liquid to be left on the top side of the column after a spin. If this occurs, add +1 min at 3,200 RPM, then +3x 30 sec at 3,400 RPM. Check after each additional spin; stop once fully through.

### 5.2 SMRTbell Library Construction (SPK 3.0)

Input: 1.25-5 ug sheared DNA. Follow the [PacBio SMRTbell prep kit 3.0 protocol](https://www.pacb.com/wp-content/uploads/Procedure-checklist-Preparing-whole-genome-and-metagenome-libraries-using-SMRTbell-prep-kit-3.0.pdf).

### 5.3 Sequencing

**Step 5.3.1 -- Anneal-Bind-Cleanup.** Follow the Revio SPRQ chemistry procedure. Anneal sequencing primer, bind SPRQ polymerase, perform final cleanup.

**Step 5.3.2 -- Load.** Load at 250 pM with adaptive loading onto a Revio SMRT Cell. Movie time: ~24 hours. Enable on-instrument 5mC and 6mA base modification calling (ICS v13.3+).

Expected output: 90-148 Gb HiFi data per SMRT Cell. At ~18 kb mean read length, this yields ~5-8 million HiFi reads, providing 26-30x genome coverage.

---

## Part 6: Oxford Nanopore Ligation Library Preparation

*An ONT-specific protocol is being finalized. In the meantime, follow the standard [ONT LSK114 ligation sequencing protocol](https://nanoporetech.com/document/genomic-dna-by-ligation-sqk-lsk114) and use [Dorado](https://github.com/nanoporetech/dorado) with the 6mA all-context model for basecalling.*

---

## Part 7: Quality Control and Expected Metrics

### Pre-Sequencing QC Summary

| Checkpoint              | Method                   | Acceptable Range                              |
|-------------------------|--------------------------|-----------------------------------------------|
| Cell count              | Hemocytometer / counter  | 1 x 10^6 per reaction (min)                  |
| HMW DNA yield           | Qubit dsDNA HS           | 3-6 ug per million LCL cells                 |
| DNA purity              | NanoDrop                 | A260/280 = 1.8 +/- 0.1; A260/230 >= 2.0      |
| DNA integrity (pre-shear) | Femto Pulse / TapeStation | Mode >50 kb; GQN >= 7.0 at 10 kb           |
| Post-shearing size      | Femto Pulse / TapeStation | 15-20 kb (PacBio) or 20-35 kb (ONT)         |
| SMRTbell library        | Qubit                    | >= 300 ng total per Revio SPRQ SMRT Cell      |
| ONT adapted library     | Qubit                    | 200-700 ng; load ~300 ng                     |

### Post-Sequencing QC (Fiber-seq-Specific)

Use the [fibertools](../fibertools/fibertools.md) software suite to assess data quality:

**m6A autocorrelation function (ACF):** Run `ft qc --acf input.bam`. A successful experiment produces a clear periodic signal at 147 bp, reflecting nucleosome protection. This is the single most important QC metric.

**Global m6A fraction:** Should be 0.03-0.09 (median per fiber) or 5-7% globally.

**Nucleosome length distribution:** After [`ft predict-m6a`](../fibertools/creating/predict.md) (PacBio) or `ft add-nucleosomes` (ONT/PacBio), footprint lengths should show a mode at ~147 bp.

**FIRE element calling:** Run the [FIRE pipeline](../fire/fire.md) at >= 95% precision. FIRE peaks should overlap with DNase-HS and ATAC-seq peaks.

**HiFi read metrics (PacBio):** Read-length N50 of 17-18 kb, >93% bases at Q30+, >= 30x genome coverage.

**Negative control:** WGA DNA (no Hia5) processed identically should show <1% false-positive m6A.

---

## Part 8: Workflow Summary and Timeline

| Day | Step | Time | Key Parameters |
|-----|------|------|---------------|
| Day 1 | Cell harvest, PBS wash | 15 min | 1M LCL cells, 350 x g |
| | Lysis | 10 min on ice | 0.025-0.05% IGEPAL final |
| | Hia5 labeling | 10 min at 25 C | 200 U Hia5, 0.8 mM SAM |
| | Quench + bring to volume | 2 min | 1% SDS final, PBS to kit volume |
| | HMW DNA extraction | 1-2 hr | Qiagen MagAttract (preferred) |
| | QC: Qubit + Femto Pulse | 30 min | Verify yield and size |
| | | | ~2-2.5 hr total from pellet to purified DNA |
| Day 2 (PacBio) | Shear DNA | 30 min | Megaruptor 3 or g-TUBE |
| | SMRTbell library prep | 4-5 hr | SPK 3.0: Repair, Ligate, Nuclease |
| | Size selection | 1-2 hr | AMPure PB or BluePippin |
| | QC + ABC + Load Revio | ~3 hr | 250 pM, 24 hr movie |
| Day 2 (ONT) | Optional shearing | 10 min | 26G needle, 25 passes |
| | End-prep | 35 min | LSK114 + NEBNext E7672 |
| | Adapter ligation | 10-60 min | Room temperature |
| | QC + Load flow cell | 15 min | 300 ng on R10.4.1 |

**Total hands-on time from cells to sequencing-ready library:** ~6-8 hours (including QC pauses). The Hia5 labeling step itself takes only 10 minutes.

---

## Essential Citations and Resources

### Primary Fiber-seq Publications

- Stergachis AB et al. Single-molecule regulatory architectures captured by chromatin fiber sequencing. *Science* 2020. 368(6498):1449-1454. DOI: [10.1126/science.aaz1646](https://doi.org/10.1126/science.aaz1646).
- Vollger MR et al. Synchronized long-read genome, methylome, epigenome, and transcriptome profiling resolve a Mendelian condition. *Nature Genetics* 2025. 57(2):469-479. DOI: [10.1038/s41588-024-02067-0](https://doi.org/10.1038/s41588-024-02067-0).
- Jha A et al. DNA-m6A calling and integrated long-read epigenetic and genetic analysis with fibertools. *Genome Research* 2024. 34(11):1976-1986. DOI: [10.1101/gr.279095.124](https://doi.org/10.1101/gr.279095.124).
- Vollger MR et al. A haplotype-resolved view of human gene regulation. *bioRxiv* 2025. DOI: [10.1101/2024.06.14.599122](https://doi.org/10.1101/2024.06.14.599122). (FIRE pipeline).
- Bohaczuk SC et al. Resolving the chromatin impact of mosaic variants with targeted Fiber-seq. *Genome Research* 2024. 34(12):2269-2278.
- Peter CJ et al. Single chromatin fiber profiling and nucleosome position mapping in the human brain. *Cell Reports Methods* 2024. 4(12):100911.
- Swanson EG et al. Mapping single-cell diploid chromatin fiber architectures using DAF-seq. *Nature Biotechnology* 2025. DOI: [10.1038/s41587-025-02914-3](https://doi.org/10.1038/s41587-025-02914-3).
- Drozdz M et al. Novel non-specific DNA adenine methyltransferases. *Nucleic Acids Research* 2012. 40(5):2119-2130. PMID: 22102579. (Hia5 enzyme characterization).

### Online Protocols and Resources

- [Protocols.io -- Brain Fiber-seq protocol](https://www.protocols.io/view/protocol-for-6ma-labeling-and-hmw-dna-extraction-f-cgdmts46) (6mA labeling and HMW DNA extraction)
- [EpiCypher CUTANA Hia5](https://www.epicypher.com/product/cutana-hia5-for-fiber-seq/) (commercial Hia5 enzyme, SKU: 15-1032)
- [EpiCypher CUTANA Fiber-seq Kit](https://www.epicypher.com/products/fiber-seq/) (complete kit with Hia5, SAM, nuclei extraction buffer)
- [Fibertools documentation](https://fiberseq.github.io/) (computational guide for m6A calling and nucleosome annotation)
- [fibertools-rs (GitHub)](https://github.com/fiberseq/fibertools-rs) (CLI tool for Fiber-seq BAM processing)
- [FIRE pipeline (GitHub)](https://github.com/fiberseq/FIRE) (Snakemake workflow for regulatory element calling)
- [PacBio Fiber-seq Application Note](https://www.pacb.com/wp-content/uploads/Application-note-Fiber-seq-high-resolution-long-read-chromatin-fiber-sequencing-in-a-single-multiomic-assay.pdf) (PacBio document 102-326-654 REV02, Oct 2025)
- [ONT LSK114 Protocol](https://nanoporetech.com/document/genomic-dna-by-ligation-sqk-lsk114) (Ligation sequencing DNA V14)
- [Dorado basecaller](https://github.com/nanoporetech/dorado) (use with 6mA all-context model for Fiber-seq)
