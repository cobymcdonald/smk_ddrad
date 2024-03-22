rule bwa_index:
    input:
        fasta=config["genome"]
    output:
        multiext(config["genome"], ".amb", ".ann", ".pac", ".0123", ".bwt.2bit.64"),
    resources:
        mem_mb=90000,
        runtime_min=lambda _, attempt: 60 * (attempt),
        cpus=20,
    conda:
        "../envs/bwamem2.yml",
    log:
        "logs/bwa_index/PumCon1.log"
    shell:
        "(bwa-mem2 index {input.fasta}) 2> {log}"
