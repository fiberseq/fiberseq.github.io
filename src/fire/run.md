# Running the FIRE pipeline

The FIRE pipeline is a Snakemake workflow for calling Fiber-seq Inferred Regulatory Elements (FIREs) on single molecules and peak calling with Fiber-seq.

---

**⚠️ WARNING**

**This pipeline generates peak-calls and trackHubs for whole genome Fiber-seq datasets. If instead you only want to add FIRE elements to a BAM file see: [ft fire](../fibertools/creating/fire.md#i-just-need-the-fire-elements).** You will also want to use `ft fire` if your dataset is not whole genome, as the FIRE pipeline requires a whole genome dataset for the FDR calibration used in peak-calling.

---

## Install

Please start by installing [pixi](https://pixi.sh/latest/) which handles the environment of the FIRE workflow.

Then install FIRE using `git` and `pixi`:

```bash
git clone https://github.com/fiberseq/FIRE.git
cd FIRE
pixi install
```

We then recommend quickly testing your installation by running the test suite:

```bash
pixi run test
```

We recommend setting a Snakemake conda prefix in your `bashrc`, e.g. in the Stergachis lab add:

```bash
export SNAKEMAKE_CONDA_PREFIX=/mmfs1/gscratch/stergachislab/snakemake-conda-envs
```

Then Snakemake installs all the additional requirements as conda envs in that directory.

If you wish to distribute jobs across a cluster you may need to install the appropriate [snakemake executor plugin](https://snakemake.github.io/snakemake-plugin-catalog/). The SLURM executor is included in the environment (`snakemake-executor-slurm`)

## Configuring

See the [configuration README](https://github.com/fiberseq/FIRE/tree/main/config), the example [configuration file](https://github.com/fiberseq/FIRE/blob/main/config/config.yaml), and the example [manifest file](https://github.com/fiberseq/FIRE/blob/main/config/config.tbl) for configuration options.

---

**⚠️ ONT users**

If you are using ONT please follow the preprocessing steps outlined [here](../quick-start.md#fiber-seq-starting-with-oxford-nanopore-technologies-ont), and then be sure to **include `ont: true` in your FIRE config file (e.g. `config.yaml`)**. This will ensure that the correct parameters are used for the `ft fire` command.

---

## Run

The `FIRE` workflow can be executed using the `pixi run fire` command. Under the hood this runs a `snakemake` workflow and any extra parameters are passed directly to snakemake. For example:

```bash
pixi run fire --configfile config/config.yaml
```

If you want to do a dry run:

```bash
pixi run fire --configfile config/config.yaml -n
```

If you want to execute across a cluster (modify `profiles/slurm-executor` as needed for distributed execution):

```bash
pixi run fire --configfile config/config.yaml --profile profiles/slurm-executor
```

And if you want to run the FIRE workflow from another directory you can do so with:

```bash
pixi run --manifest-path /path/to/snakemake/pixi.toml fire ...
```

where you update `/path/to/snakemake/pixi.toml` to the path of the `pixi.toml` in the cloned FIRE repository.

You can also run snakemake directly, e.g.:

```bash
pixi shell
snakemake \
  --configfile config/config.yaml \
  --profile profiles/slurm-executor \
  --local-cores 8 -k
```
