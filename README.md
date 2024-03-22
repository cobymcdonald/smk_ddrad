Snakemake ddRAD pipeline
================
Last updated: 2024-03-21

- [Summary](#summary)
- [Notes](#notes)
- [Preconditions](#preconditions)
- [Implementing the pipeline](#implementing-the-pipeline)
- [Usage notes](#usage-notes)
- [Things I’ve learned along the way](#things-ive-learned-along-the-way)
- [Future goals](#future-goals)

# Summary

This is a simple pipeline to call SNPs from ddRAD sequencing data using
[`STACKS`](https://catchenlab.life.illinois.edu/stacks/). Currently, it
will take raw, paired end sequencing files, and do the following:

1.  remove PCR clones with `clone_filter`
2.  remove degenerate barcodes with `cutadapt`
3.  demultiplex reads with `process_radtags`
4.  align sample reads with `bwa-mem2`
5.  call SNPs with `gstacks`
6.  generate summary stats and .vcf via `populations`

# Notes

1.  As of `Stacks` 2.62, multithreading for `process_radtags` has been
    added and speeds everything up considerably. This pipeline is
    currently set up to work with v2.65, but that can easily be
    changed/updated with the stacks environment .yml.
2.  The pipeline takes two config files. The first is for data
    configuration, which stores information like the genome used,
    `Stacks` parameters, etc., and is stored in the ./config directory.
    It doesn’t need to be named config.yaml, and can be called something
    more descriptive (e.g., pconcolor.yaml). The second config is the
    cluster config file, which specifies SLURM arguments. This file
    *does* need to be specifically named config.yaml.

# Preconditions

1.  Raw fastq.gz sequencing files.
2.  A `units.csv` with columns for the index used, the library name, the
    absolute file paths for R1 and R2 reads, an easy-to-read sample ID,
    a units column for replicates, and a column for sample ID, as such:

| index  | lib        | fq1                         | fq2                         | sample | unit | fwc_withrep     |
|:-------|:-----------|:----------------------------|:----------------------------|:-------|-----:|:----------------|
| ATCACG | idx1concat | data/raw/idx1concat_1.fq.gz | data/raw/idx1concat_2.fq.gz | S001   |    1 | FP059           |
| ATCACG | idx1concat | data/raw/idx1concat_1.fq.gz | data/raw/idx1concat_2.fq.gz | S002   |    1 | FP158           |
| ATCACG | idx1concat | data/raw/idx1concat_1.fq.gz | data/raw/idx1concat_2.fq.gz | S003   |    1 | FP206           |
| ATCACG | idx1concat | data/raw/idx1concat_1.fq.gz | data/raw/idx1concat_2.fq.gz | S004   |    1 | FP073K018F1rep1 |
| ATCACG | idx1concat | data/raw/idx1concat_1.fq.gz | data/raw/idx1concat_2.fq.gz | S005   |    1 | FP127rep1       |
| ATCACG | idx1concat | data/raw/idx1concat_1.fq.gz | data/raw/idx1concat_2.fq.gz | S006   |    1 | FP200BigGuyrep1 |

# Implementing the pipeline

The full snakemake pipeline can be implemented like so:

``` bash
snakemake --profile ./slurm_config/ results/populations/populations.snps.vcf -np
```

- `-np` invokes the job as a dry run and prints all the required steps.
  Once a dry run can be performed without errors, simply delete this
  parameter to run the job in full.
- note that the `--profile` parameter should point to the directory that
  *contains* the slurm config file, not to the file itself
- also note that the desired results file should be listed as
  `results/...`, not `./results/..`, as the latter will throw an error.

# Usage notes

The main obstacle with ddRAD and snakemake is that snakemake is
output-oriented, so in a way it works backward and all output files need
to be specified explicitly. This is a challenge for demultiplexing with
`process_radtags`, where you can’t easily use wildcards for the output
files. Eric Anderson sorted this out for me via this
[repo](https://github.com/eriqande/many-outputs-from-each-of-several-inputs-with-Snakemake).
Essentially, the easiest approach is to use a for loop to hard-write one
rule for each indexed library. For example, in a dataset with nine
unique indexes, we write nine separate rules so that each rule lists the
unique output files via a dictionary–see
[`process_radtags.smk`](workflow/rules/). This allows us to easily
specify all of the dozens of demultiplexed output files
(e.g. X1412.1.fq.gz, X2054.2.fq.gz) for each of the indexed libraries we
use as input.

# Things I’ve learned along the way

1.  Apparently snakemake runs within the rules directory, so if using
    conda, make sure to specify either the absolute path to the .yaml,
    or the relative path (which should be one directory back).
2.  Snakemake can be used on a cluster in a couple ways. First, you can
    type all the SLURM arguments manually in the command line. Second,
    you can generate a cluster profile. This can be done using
    `cookiecutter` and one of the template SLURM profiles on the
    snakemake github
    [site](https://github.com/Snakemake-Profiles/slurm). I’ve found that
    the easier and simpler way that works for me is to use jdblischak’s
    [approach](https://github.com/jdblischak/smk-simple-slurm).
3.  An added bonus of jdblischak’s repo is an example of how to
    dynamically allocate resources, which has been huge for me because I
    didn’t know exactly how long/how much memory some programs would
    need. Dynamic allocation allows one to incrementally increase
    memory/time/cpus in the event that a job fails due to the current
    iteration of resource allocation.
4.  Another great feature of using a cluster profile with snakemake is
    the ability to restrict total resource usage. For example, I have my
    cluster config file set to use no more than one-third of the ovis
    server resources at any given time. This is just a nice thing to do
    when using a shared server. By setting the max resources, snakemake
    will limit the number of jobs accordingly. For example, setting
    resources mem_mb to 300000 mb will result in no more than 3 90GB
    memory jobs running at any one time. I learned to do this via this
    [blog
    post](https://www.sichong.site/workflow/2021/11/08/how-to-manage-workflow-with-resource-constraint.html).

# Future goals

1.  Currently the pipeline will take PE reads. I would like to edit it
    such that it will work with either PE or SE reads.
2.  The samples metadata has a column for ‘units’ so that if any samples
    are re-sequenced, they can be specified for re-running the pipeline.
    Right now that functionality is not built into the code.
