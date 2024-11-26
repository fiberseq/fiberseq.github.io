## Haplotype-selective peaks

### Haplotype-selective peaks
For peaks with at least 10 Fiber-seq reads on both haplotypes, we test the difference in percent actuation in each haplotype (fraction of reads with FIRE elements) using a two-sided Fisher’s exact test. Specifically, the inputs for the test are the number of FIRE elements in haplotype one, the number of Fiber-seq reads without FIRE elements in haplotype one, the number of FIRE elements in haplotype two, and the number of Fiber-seq reads without FIRE elements in haplotype two. We then apply an FDR correction (Benjamini-Hochberg) to correct for multiple testing. 

