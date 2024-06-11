## Aggregation of FIRE elements for peak calling

### Aggregate FIRE score calculation

The FIRE score (\\(S_g\\)) for a position in the genome (\\(g\\)) is calculated using the following formula:

 \\[ S_g=-\frac{50}{R_g} \\sum_{i=1}^{C_g} \log_{10}(1-min(EP_i , 0.99)) \\]

where \\(C_g\\) is the number of FIRE elements at the \\(g\\)th position, \\(R_g\\) is the number of Fiber-seq reads at the \\(g\\)th position, and \\(EP_i\\) is the estimated precision of the \\(i\\)th FIRE element at the \\(g\\)th position. The estimated precision of each FIRE element is thresholded at 0.99, such that the FIRE score takes on values between 0 and 100. Regions covered by less than four FIRE elements (i.e., if \\(C_g < 4\\))  are not scored and are given a value of negative one. 

### Regions of unreliable coverage
Regions with unreliable coverage are defined as regions with Fiber-seq coverage that deviate from the median coverage by five standard deviations, where a standard deviation is defined by the Poisson distribution (i.e., the square root of the mean coverage). This is a parameter that can be adjusted by the user.

### FIRE score FDR calculation
We shuffle the location of an entire Fiber-seq read by selecting a random start position within the chromosome and relocating the entire read to that start position. Fiber-seq reads originating from regions with unreliable coverage (defined above) are not shuffled, and reads from regions with reliable coverage are not shuffled into regions with unreliable coverage (`bedtools shuffle -chrom -excl`, v2.31.0) (Quinlan & Hall, 2010). We then compute FIRE scores associated with the shuffled genome. Recalling that the FIRE score for the \\(g\\)th position in the genome is denoted \\(S_g\\), we divide the number of bases that have shuffled FIRE scores above \\(S_g\\) by the number of bases that have un-shuffled FIRE scores above \\(S_g\\). This provides an estimate of the FDR associated with the FIRE score \\(S_g\\).

### Peak calling
Peaks are called by identifying FIRE score local-maxima that have FDR values below a 5% threshold and at least 10% actuation (Cg / Rg). Adjacent local maxima that share 50% of the underlying FIRE elements or have 90% reciprocal overlap are merged into a single peak, using the higher of the two local maxima. Then, the start and end positions of the peak are determined by the median start and end positions of the underlying FIRE elements. We also calculated and reported wide peaks by taking the union of the FIRE peaks and all regions below the FDR threshold and then merged the resulting regions that were within one nucleosome (147 bp) of one another.

