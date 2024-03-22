rule gstacks:
    input:
        expand("results/bwa/{S}.bam", S = list(samples.index)), #this should only call the sample.bam, not sample.rem.bam
    output:
        "results/gstacks/catalog.calls",
        "results/gstacks/catalog.fa.gz"
    params:
        popmap=config["popmap"],
    resources:
        mem_mb=85000,
        runtime_min=lambda _, attempt: 420 + ((attempt - 1) * 60),
        cpus=18,
    conda:
        "../envs/stacks.yml",
    log:
        "logs/gstacks/gstacks.log"
    shell:
        "(gstacks -t 18 -I results/bwa -M {params.popmap} -O results/gstacks) 2> {log}"
