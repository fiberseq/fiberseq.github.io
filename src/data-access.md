# Data Access

## Broadly Consented Data Downloads

We provide access to broadly consented Fiber-seq data that can be used by researchers for various genomic studies.

### Available Datasets

Our broadly consented datasets include the following samples:

- **CHM1**: Complete hydatidiform mole cell line
- **CHM13**: Complete hydatidiform mole cell line (GRCh38 alignment)
- **CHM13_DSA**: CHM13 data aligned against the DSA (T2Tv2.0)
- **GM12878**: Lymphoblastoid cell line from Coriell Cell Repository
- **HG002**: Human genome reference sample (Ashkenazi Jewish trio son)
- **K562**: Chronic myelogenous leukemia cell line

All samples are processed with FIRE (Fiber-seq Inferred Regulatory Elements).

### Data Formats

All datasets are provided in standard formats:

- **Fiber-seq CRAM files**: Primary data format containing m6A calls and nucleosome positions
- **Processed FIRE outputs**: Summary statistics, peaks, and aggregated results

### Download Instructions

#### Browse Available Data

You can explore all available samples using the AWS CLI:

```bash
aws s3 ls --no-sign-request --endpoint-url https://s3.kopah.uw.edu s3://stergachis/public/FIRE/broadly-consented/
```

#### Download Data

To download specific samples or datasets, use the AWS CLI with the following pattern:

```bash
aws s3 sync --no-sign-request --endpoint-url https://s3.kopah.uw.edu s3://stergachis/public/FIRE/broadly-consented/[SAMPLE_NAME]/ ./[LOCAL_DIRECTORY]/
```

For example, to download CHM13 data:

```bash
aws s3 sync --no-sign-request --endpoint-url https://s3.kopah.uw.edu s3://stergachis/public/FIRE/broadly-consented/CHM13/ ./CHM13_data/
```

### Data Use Guidelines

When using our broadly consented data, please:

- Cite the original studies and data contributors

### HPRCv2 Fiber-seq CRAMs

We also provide access to Fiber-seq CRAM for the HPRCv2 release. These CRAMs contain m6A calls, MSP calls, and nucleosome calls for each of the HPRCv2 samples with Fiber-seq data.

You can find these CRAMs in the following S3 bucket. Data is aligned both to the Donor Specific Assembly (`dsa`) and to GRCh38 (`shared.ref`).

```bash
aws s3 ls --no-sign-request --endpoint-url https://s3.kopah.uw.edu 's3://stergachis/public/HPRCv2/FIRE-bams/'
```

### HPRCv2 FIRE Peaks

We provide pangenome graph-based union peak calls for the HPRCv2 Fiber-seq samples. These peaks are called on donor-specific assemblies and then projected to multiple coordinate systems. For full column definitions, thresholds, and methodology, see the
  [README](https://s3.kopah.uw.edu/stergachis/public/HPRCv2/FIRE-peaks/union-peaks-README.md) included in the bucket.

#### Available files

**Union peaks** (every sample × consensus peak that passes in at least one sample):

  | File | Coordinates |
  |------|-------------|
  | `union-peaks-cons.bed.gz` | Pangenome graph consensus (shown in T2T-CHM13 coords when possible) |
  | `union-peaks-chm13.bed.gz` | T2T-CHM13 reference paths |
  | `union-peaks-asm.bed.gz` | Per-sample assembly contigs |
  | `union-peaks-hg38.bed.gz` | GRCh38 liftover |

**Called peaks** (filtered to sites passing thresholds: FIRE coverage ≥ 4, fraction accessible ≥ 0.2):

  | File | Coordinates |
  |------|-------------|
  | `peaks-cons.bed.gz` | Pangenome graph consensus (shown in T2T-CHM13 coords when possible) |
  | `peaks-chm13.bed.gz` | T2T-CHM13 reference paths |
  | `peaks-asm.bed.gz` | Per-sample assembly contigs |
  | `peaks-hg38.bed.gz` | GRCh38 liftover |

All files are bgzipped BED files with a `#chrom` header line and tabix indices (`.tbi`).

#### Download

Browse available files:
```bash
aws s3 ls --no-sign-request --endpoint-url https://s3.kopah.uw.edu 's3://stergachis/public/HPRCv2/FIRE-peaks/'
```

Download all peak files:
```bash
aws s3 sync --no-sign-request --endpoint-url https://s3.kopah.uw.edu s3://stergachis/public/HPRCv2/FIRE-peaks/ ./FIRE-peaks/
```
