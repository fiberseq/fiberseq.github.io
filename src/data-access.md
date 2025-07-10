# Data Access

## Broadly Consented Data Downloads

We provide access to broadly consented Fiber-seq data that can be used by researchers for various genomic studies. This data has been generated under broad consent agreements, allowing for general research use without additional authorization requirements.

### Available Datasets

Our broadly consented datasets include the following samples:

- **CHM1**: Complete hydatidiform mole cell line
- **CHM13**: Complete hydatidiform mole cell line (T2T reference)
- **CHM13_DSA**: CHM13 with DSA treatment
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
