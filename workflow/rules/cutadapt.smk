rule cutadapt:
    input:
        R2="results/clone_filter/{lib}_2.2.fq.gz",
        R1="results/clone_filter/{lib}_1.1.fq.gz",
    output:
        R1="results/cutadapt/{lib}_1.ca.fq.gz",
        R2="results/cutadapt/{lib}_2.ca.fq.gz",
    resources:
        cpus=20,
        mem_mb=90000,
        runtime_min=60,
    conda:
        "../envs/cutadapt_smk.yml",
    log:
        "logs/cutadapt/{lib}.log",
    shell:
        "(cutadapt -u 10 -j 20 -o {output.R2} -p {output.R1} {input.R2} {input.R1}) 2> {log}"
