# Running the FIRE pipeline

The FIRE pipeline is a Snakemake workflow for calling Fiber-seq Inferred Regulatory Elements (FIREs) on single molecules and peak calling with Fiber-seq. 

## Install

To run FIRE please install `snakemake` and all the UCSC Kent utilities. 

**snakemake** can be installed using conda/mamba, e.g.:
```
mamba create -c conda-forge -c bioconda -n snakemake 'snakemake>=8.20'
```

Finally, if you wish to distribute jobs across a cluster you will need to install the appropriate [snakemake executor plugin](https://snakemake.github.io/snakemake-plugin-catalog/). For example, to use SLURM you can install the `snakemake-executor-slurm` plugin using pip:
```  
pip install snakemake-executor-plugin-slurm
```

We recommend setting a snakemake conda prefix and the apptainer cache directory in your `bashrc`, e.g. in the Stergachis lab add:
```bash
export SNAKEMAKE_CONDA_PREFIX=/mmfs1/gscratch/stergachislab/snakemake-conda-envs
export APPTAINER_CACHEDIR=/mmfs1/gscratch/stergachislab/snakemake-conda-envs/apptainer-cache
```

Then snakemake installs all the additional requirements as conda envs in that directory.



## Configuring

See the [configuration README](https://github.com/fiberseq/FIRE/tree/main/config), the example [configuration file](https://github.com/fiberseq/FIRE/blob/main/config/config.yaml), and the example [manifest file](https://github.com/fiberseq/FIRE/blob/main/config/config.tbl) for configuration options.


## Running

We have a run script that executes the FIRE snakemake called `fire`, and any extra parameters are passed directly to snakemake. For example:

```bash
./fire --configfile config/config.yaml
```

If you want to do a dry run:

```bash
./fire --configfile config/config.yaml -n
```

If you want to execute across a cluster (modify `profiles/slurm-executor` as needed for distributed execution):

```bash
./fire --configfile config/config.yaml --profile profiles/slurm-executor
```

You can also run snakemake directly, e.g.:

```bash
snakemake \
  --configfile config/config.yaml \
  --profile profiles/slurm-executor \
  --local-cores 8 -k
```

## Test data

You can find input data to test against at [this url](https://s3-us-west-2.amazonaws.com/stergachis-public1/index.html?prefix=FIRE/test-data/).
