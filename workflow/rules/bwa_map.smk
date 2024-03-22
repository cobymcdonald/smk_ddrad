rule bwa_map:
    input:
        multiext(config["genome"], ".amb", ".ann", ".pac", ".0123", ".bwt.2bit.64"),
        idx=config["genome"],
        R1="results/process_radtags/{sample}.1.fq.gz",
        R2="results/process_radtags/{sample}.2.fq.gz",
    output:
        bam="results/bwa/{sample}.bam",
        stats="results/bwa/{sample}.stats",
    params:
        header="\"@RG\\tID:{sample}\\tSM:{sample}\\tPL:ILLUMINA\\tCN:NovogeneDavis\"",
    resources:
        mem_mb=lambda _, attempt: 54000 + ((attempt - 1) * 2000),
        runtime_min=lambda _, attempt: 100 * (attempt),
    conda:
        "../envs/bwamem2.yml",
    log:
        "logs/bwa_map/{sample}.log",
    shell:
        '''(bwa-mem2 mem -R {params.header} {input.idx} {input.R1} {input.R2} | samtools view -bhS - | samtools sort -o {output.bam}) 2> {log}; samtools flagstat {output.bam} &> {output.stats}'''
