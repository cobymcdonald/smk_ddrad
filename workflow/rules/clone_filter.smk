# Remove PCR duplicates prior to demultiplexing

rule clone_filter:
    input:
        unpack(fq_dict)
    output:
        "results/clone_filter/{lib}_1.1.fq.gz",
        "results/clone_filter/{lib}_2.2.fq.gz"
    resources:
        cpus=1,
        mem_mb=15000,
        runtime_min=lambda _, attempt: 840 * (attempt),
    conda:
        "../envs/stacks.yml",
    log:
        "logs/clone_filter/{lib}.log"
    shell:
        "(clone_filter -i gzfastq -1 {input.fq1} -2 {input.fq2} --inline_null --oligo_len_2 10 -o results/clone_filter/) 2> {log}"
