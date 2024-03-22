rule populations:
    input:
        "results/gstacks/catalog.fa.gz",
        "results/gstacks/catalog.calls"
    output:
        "results/populations/populations.snps.vcf"
    params:
        #min_mac= 2,
        #max_het= 0.5,
        #r= 0.25,
        #p= 1
        #add more params here as necessary
    resources:
        mem_mb=90000,
        runtime_min=420,
        cpus=20,
    conda:
        "../envs/stacks.yml",
    log:
        "logs/populations/populations.log"
    shell:
        "(populations -t 20 -P results/gstacks/ -O results/populations/ -M data/popmap.tsv --vcf --write-single-snp) 2> {log}"
