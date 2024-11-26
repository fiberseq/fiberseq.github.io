# FIRE: descriptions, methods, and outputs

The code for running the FIRE pipeline can be found on [GitHub](https://github.com/fiberseq/FIRE), and if you do use FIRE in your work please cite our publication:

> **Vollger, M. R.**, **Swanson, E. G.**, Neph, S. J., Ranchalis, J., Munson, K. M., Ho, C.-H., Sedeño-Cortés, A. E., Fondrie, W. E., Bohaczuk, S. C., Mao, Y., Parmalee, N. L., Mallory, B. J., Harvey, W. T., Kwon, Y., Garcia, G. H., Hoekzema, K., Meyer, J. G., Cicek, M., Eichler, E. E., … Stergachis, A. B. (2024). A haplotype-resolved view of human gene regulation. _bioRxiv_. [https://doi.org/10.1101/2024.06.14.599122](https://doi.org/10.1101/2024.06.14.599122)

## Summary of Fiber-seq inferred regulatory elements (FIREs)

For those who would prefer video I have recorded a [lab meeting](https://youtu.be/RiZrMltAiWM?si=sSo64goaNQxgyfcc) discussing FIRE and the methods used here. If you prefer to read please continue on.

FIREs are MTase sensitive patches (MSPs) that are inferred to be regulatory elements on single chromatin fibers. To do this we used semi-supervised machine learning to identify MSPs that are likely to be regulatory elements using the `Mokapot` framework and `XGBoost`. Every individual FIRE element is associated with an estimated precision value (defined below), which indicates the probability that the FIRE element is a true regulatory element. The estimated precision of FIREs elements are created using `Mokapot` and validation data not used in training. We train our model targeting FIRE elements with at least 95% precision, MSPs with less than 90% precision are considered to have average level of accessibility expected between two nucleosomes, and are referred to as linker regions.

Semi-superivized machine learning with `Mokapot` requires a mixed-positive training set and a clean negative training set. To create mixed positive training data we selected MSPs that overlapped DNase hypersensitive sites (DHSs) and CTCF ChIP-seq peaks. And to create a clean negative training set we selected MSPs that did not overlap DHSs or CTCF ChIP-seq peaks.

For details on running the FIRE workflow see:

- [Running and installing](run.md)

For details on the outputs of the FIRE workflow see:

- [Outputs](outputs.md)
