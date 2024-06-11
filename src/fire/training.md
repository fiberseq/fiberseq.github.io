## Training of Fire-seq inferred regulatory elements.

### Training data

For training data, we generated 21 different GM12878 Fiber-seq experiments with a range of under- and over-methylated experimental conditions to ensure we captured a broad range of percent m6A (Fig. S1; 5.8-13.3%) to ensure our model could generalize to new samples with varying levels of m6A. We merged these sequencing results and randomly selected 10% of the Fiber-seq reads from 100,000 randomly selected DNase I and CTCF ChIP-seq peaks for mixed-positive labels and 100,000 equally sized regions that did not overlap DNase or CTCF Chip-seq for negative labels. We then generated features for each of these MSPs, including length, log fold enrichment of m6A, the A/T content, and windowed measures of m6A around the MSP (Supplemental Table 3) and held out 20% of the Fiber-seq reads to be used as test data.

### Semi-supervised training

To carry out semi-supervised training, we used an established method, Mokapot (Fondrie & Noble, 2021; Käll et al., 2007), which we summarize below. In the first round of semi-supervised training, Mokapot identifies the feature that best discriminates between our mixed-positive and negative labels and then selects a threshold for that feature such that the mixed-positive labels can be discriminated from the negative labels with 95% estimated precision (defined below). The subset of mixed-positive labels above this threshold is then used as an initial set of positive labels in training an XGBoost model with five-fold cross-validation (Chen & Guestrin, 2016). Then this process is iteratively repeated, using the learned prediction from the previous iteration’s model to create positive labels at 95% estimated precision, until the number of positive identifications at 95% precision in the validation set ceases to increase (15 iterations, Fig. S1) (Fondrie & Noble, 2021; Käll et al., 2007). 


### Features of FIRE elements

The following features were used as features with `Mokapot` in FIRE element classification:

| Feature | Description |
| ------- | ----------- |
| msp_len | Length of the MSP |
| msp_len_times_m6a_fc | Length of the MSP times the fold-change of m6A in the MSP |
| ccs_passes | Number of CCS passes in the MSP |
| fiber_m6a_count | Number of m6A sites in the Fiber-seq read |
| fiber_AT_count | Number of AT sites in the Fiber-seq read |
| fiber_m6a_frac | Fraction of m6A sites in the Fiber-seq read |
| msp_m6a | Number of m6A sites in the MSP |
| msp_AT | Number of AT sites in the MSP |
| msp_m6a_frac | Fraction of m6A sites in the MSP |
| msp_fc | Fold-change of m6A fraction in the MSP relative to the whole reads m6A fraction |
| m6a_count_X | Number of m6A sites in the Xth 40 bp window |
| AT_count_X | Number of AT sites in the Xth 40 bp window |
| m6a_frac_X | Fraction of m6A sites in the Xth 40 bp window |
| m6a_fc_X | Fold-change of m6A fraction in the Xth 40 bp window relative to the whole reads m6A fraction |

There are nine 40 bp windows for each MSP (X = 1, 2, ..., 9), with the 5th window centered on the MSP. 


### Estimated precision of individual FIRE elements

We cannot compute the precision associated with a particular XGBoost score because we do not have access to a set of clean-positive labels. Instead, we define a notion of “estimated precision” using a balanced held-out test set of mixed-positive and negative labels (20% of the data). We defined the estimated precision (EP) of a FIRE element to be

\\[ EP = 1 - \frac{FP+1}{TMP} \\]

where TMP is the number of “true” identifications from the mixed positive labels with at least that element’s XGBoost score, and FP is the number of false positive identifications from negative labels with at least that element’s XGBoost score. We add a pseudo count of one to the numerator of false positive identifications so as to prevent liberal estimates for smaller collections of identifications (Fondrie & Noble, 2021).

