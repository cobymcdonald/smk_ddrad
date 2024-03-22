import pandas as pd

# read in units file, set samples as index (for process_radtags and bwa-map)
samples = pd.read_csv("data/units.csv").set_index("sample")

# set libs as index (for clone_filter and cutadapt)
libs = samples[["index","lib","fq1","fq2"]].drop_duplicates().set_index("lib")

# create list of libraries (for process_radtags)
lib_list = list(libs.index)

# create dict to retrieve raw files
def fq_dict(wildcards):
  return {
    "fq2": libs.loc[wildcards.lib, "fq2"],
    "fq1": libs.loc[wildcards.lib, "fq1"]
  }

# write functions to return all demultiplexed samples associated with a library (these are python functions, NOT smk input functions)
def demult_fq1(L):
    s = list(samples.loc[samples['lib'] == L].index)
    return expand("results/process_radtags/{S}.1.fq.gz", S = s)

def demult_fq2(L):
    s = list(samples.loc[samples['lib'] == L].index)
    return expand("results/process_radtags/{S}.2.fq.gz", S = s)

# create dicts of all demultiplexed fq1 and fq2 outfiles
demult1_dict = dict()
for L in lib_list:
    demult1_dict[L] = demult_fq1(L)

demult2_dict = dict()
for L in lib_list:
    demult2_dict[L] = demult_fq2(L)

# use python to write separate rule for each library in process_radtags.smk
rule_template = """
rule demult_{L}:
    input:
        in1="results/clone_filter/{L}_1.1.fq.gz",
        in2="results/clone_filter/{L}_2.2.fq.gz",
    output:
        demult1_dict['{L}'],
        demult2_dict['{L}'],
    params:
        enz1= config["process_radtags"]["enzyme1"],
        #enz2= config["process_radtags"]["enzyme2"],
        barcodes= "data/barcodes/{L}_barcodes.tsv",
    resources:
        cpus=10,
        mem_mb=90000,
        runtime_min=lambda _, attempt: 420 + ((attempt - 1) * 60),
    conda:
        "../envs/stacks.yml",
    log:
        "logs/demult_{L}/{L}.log",
    shell:
        "(process_radtags -i gzfastq --threads 10 --inline_null -1 {{input.in1}} -2 {{input.in2}} -o results/process_radtags/ -b {{params.barcodes}} -c -r -q --renz-1 {{params.enz1}}) 2> {{log}}"
"""

with open('workflow/rules/process_radtags.smk','w') as myfile:
    for L in lib_list:
        myfile.write(rule_template.format(L = L))
