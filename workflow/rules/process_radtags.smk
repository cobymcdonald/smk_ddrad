
rule demult_idx1concat:
    input:
        in1="results/clone_filter/idx1concat_1.1.fq.gz",
        in2="results/clone_filter/idx1concat_2.2.fq.gz",
    output:
        demult1_dict['idx1concat'],
        demult2_dict['idx1concat'],
    params:
        enz1= config["process_radtags"]["enzyme1"],
        #enz2= config["process_radtags"]["enzyme2"],
        barcodes= "data/barcodes/idx1concat_barcodes.tsv",
    resources:
        cpus=10,
        mem_mb=90000,
        runtime_min=lambda _, attempt: 420 + ((attempt - 1) * 60),
    conda:
        "../envs/stacks.yml",
    log:
        "logs/demult_idx1concat/idx1concat.log",
    shell:
        "(process_radtags -i gzfastq --threads 10 --inline_null -1 {input.in1} -2 {input.in2} -o results/process_radtags/ -b {params.barcodes} -c -r -q --renz-1 {params.enz1}) 2> {log}"

rule demult_idx2concat:
    input:
        in1="results/clone_filter/idx2concat_1.1.fq.gz",
        in2="results/clone_filter/idx2concat_2.2.fq.gz",
    output:
        demult1_dict['idx2concat'],
        demult2_dict['idx2concat'],
    params:
        enz1= config["process_radtags"]["enzyme1"],
        #enz2= config["process_radtags"]["enzyme2"],
        barcodes= "data/barcodes/idx2concat_barcodes.tsv",
    resources:
        cpus=10,
        mem_mb=90000,
        runtime_min=lambda _, attempt: 420 + ((attempt - 1) * 60),
    conda:
        "../envs/stacks.yml",
    log:
        "logs/demult_idx2concat/idx2concat.log",
    shell:
        "(process_radtags -i gzfastq --threads 10 --inline_null -1 {input.in1} -2 {input.in2} -o results/process_radtags/ -b {params.barcodes} -c -r -q --renz-1 {params.enz1}) 2> {log}"

rule demult_idx3concat:
    input:
        in1="results/clone_filter/idx3concat_1.1.fq.gz",
        in2="results/clone_filter/idx3concat_2.2.fq.gz",
    output:
        demult1_dict['idx3concat'],
        demult2_dict['idx3concat'],
    params:
        enz1= config["process_radtags"]["enzyme1"],
        #enz2= config["process_radtags"]["enzyme2"],
        barcodes= "data/barcodes/idx3concat_barcodes.tsv",
    resources:
        cpus=10,
        mem_mb=90000,
        runtime_min=lambda _, attempt: 420 + ((attempt - 1) * 60),
    conda:
        "../envs/stacks.yml",
    log:
        "logs/demult_idx3concat/idx3concat.log",
    shell:
        "(process_radtags -i gzfastq --threads 10 --inline_null -1 {input.in1} -2 {input.in2} -o results/process_radtags/ -b {params.barcodes} -c -r -q --renz-1 {params.enz1}) 2> {log}"

rule demult_idx4concat:
    input:
        in1="results/clone_filter/idx4concat_1.1.fq.gz",
        in2="results/clone_filter/idx4concat_2.2.fq.gz",
    output:
        demult1_dict['idx4concat'],
        demult2_dict['idx4concat'],
    params:
        enz1= config["process_radtags"]["enzyme1"],
        #enz2= config["process_radtags"]["enzyme2"],
        barcodes= "data/barcodes/idx4concat_barcodes.tsv",
    resources:
        cpus=10,
        mem_mb=90000,
        runtime_min=lambda _, attempt: 420 + ((attempt - 1) * 60),
    conda:
        "../envs/stacks.yml",
    log:
        "logs/demult_idx4concat/idx4concat.log",
    shell:
        "(process_radtags -i gzfastq --threads 10 --inline_null -1 {input.in1} -2 {input.in2} -o results/process_radtags/ -b {params.barcodes} -c -r -q --renz-1 {params.enz1}) 2> {log}"

rule demult_idx5concat:
    input:
        in1="results/clone_filter/idx5concat_1.1.fq.gz",
        in2="results/clone_filter/idx5concat_2.2.fq.gz",
    output:
        demult1_dict['idx5concat'],
        demult2_dict['idx5concat'],
    params:
        enz1= config["process_radtags"]["enzyme1"],
        #enz2= config["process_radtags"]["enzyme2"],
        barcodes= "data/barcodes/idx5concat_barcodes.tsv",
    resources:
        cpus=10,
        mem_mb=90000,
        runtime_min=lambda _, attempt: 420 + ((attempt - 1) * 60),
    conda:
        "../envs/stacks.yml",
    log:
        "logs/demult_idx5concat/idx5concat.log",
    shell:
        "(process_radtags -i gzfastq --threads 10 --inline_null -1 {input.in1} -2 {input.in2} -o results/process_radtags/ -b {params.barcodes} -c -r -q --renz-1 {params.enz1}) 2> {log}"

rule demult_idx6concat:
    input:
        in1="results/clone_filter/idx6concat_1.1.fq.gz",
        in2="results/clone_filter/idx6concat_2.2.fq.gz",
    output:
        demult1_dict['idx6concat'],
        demult2_dict['idx6concat'],
    params:
        enz1= config["process_radtags"]["enzyme1"],
        #enz2= config["process_radtags"]["enzyme2"],
        barcodes= "data/barcodes/idx6concat_barcodes.tsv",
    resources:
        cpus=10,
        mem_mb=90000,
        runtime_min=lambda _, attempt: 420 + ((attempt - 1) * 60),
    conda:
        "../envs/stacks.yml",
    log:
        "logs/demult_idx6concat/idx6concat.log",
    shell:
        "(process_radtags -i gzfastq --threads 10 --inline_null -1 {input.in1} -2 {input.in2} -o results/process_radtags/ -b {params.barcodes} -c -r -q --renz-1 {params.enz1}) 2> {log}"

rule demult_idx7concat:
    input:
        in1="results/clone_filter/idx7concat_1.1.fq.gz",
        in2="results/clone_filter/idx7concat_2.2.fq.gz",
    output:
        demult1_dict['idx7concat'],
        demult2_dict['idx7concat'],
    params:
        enz1= config["process_radtags"]["enzyme1"],
        #enz2= config["process_radtags"]["enzyme2"],
        barcodes= "data/barcodes/idx7concat_barcodes.tsv",
    resources:
        cpus=10,
        mem_mb=90000,
        runtime_min=lambda _, attempt: 420 + ((attempt - 1) * 60),
    conda:
        "../envs/stacks.yml",
    log:
        "logs/demult_idx7concat/idx7concat.log",
    shell:
        "(process_radtags -i gzfastq --threads 10 --inline_null -1 {input.in1} -2 {input.in2} -o results/process_radtags/ -b {params.barcodes} -c -r -q --renz-1 {params.enz1}) 2> {log}"

rule demult_idx8concat:
    input:
        in1="results/clone_filter/idx8concat_1.1.fq.gz",
        in2="results/clone_filter/idx8concat_2.2.fq.gz",
    output:
        demult1_dict['idx8concat'],
        demult2_dict['idx8concat'],
    params:
        enz1= config["process_radtags"]["enzyme1"],
        #enz2= config["process_radtags"]["enzyme2"],
        barcodes= "data/barcodes/idx8concat_barcodes.tsv",
    resources:
        cpus=10,
        mem_mb=90000,
        runtime_min=lambda _, attempt: 420 + ((attempt - 1) * 60),
    conda:
        "../envs/stacks.yml",
    log:
        "logs/demult_idx8concat/idx8concat.log",
    shell:
        "(process_radtags -i gzfastq --threads 10 --inline_null -1 {input.in1} -2 {input.in2} -o results/process_radtags/ -b {params.barcodes} -c -r -q --renz-1 {params.enz1}) 2> {log}"

rule demult_idx9concat:
    input:
        in1="results/clone_filter/idx9concat_1.1.fq.gz",
        in2="results/clone_filter/idx9concat_2.2.fq.gz",
    output:
        demult1_dict['idx9concat'],
        demult2_dict['idx9concat'],
    params:
        enz1= config["process_radtags"]["enzyme1"],
        #enz2= config["process_radtags"]["enzyme2"],
        barcodes= "data/barcodes/idx9concat_barcodes.tsv",
    resources:
        cpus=10,
        mem_mb=90000,
        runtime_min=lambda _, attempt: 420 + ((attempt - 1) * 60),
    conda:
        "../envs/stacks.yml",
    log:
        "logs/demult_idx9concat/idx9concat.log",
    shell:
        "(process_radtags -i gzfastq --threads 10 --inline_null -1 {input.in1} -2 {input.in2} -o results/process_radtags/ -b {params.barcodes} -c -r -q --renz-1 {params.enz1}) 2> {log}"

rule demult_idx1pilot:
    input:
        in1="results/clone_filter/idx1pilot_1.1.fq.gz",
        in2="results/clone_filter/idx1pilot_2.2.fq.gz",
    output:
        demult1_dict['idx1pilot'],
        demult2_dict['idx1pilot'],
    params:
        enz1= config["process_radtags"]["enzyme1"],
        #enz2= config["process_radtags"]["enzyme2"],
        barcodes= "data/barcodes/idx1pilot_barcodes.tsv",
    resources:
        cpus=10,
        mem_mb=90000,
        runtime_min=lambda _, attempt: 420 + ((attempt - 1) * 60),
    conda:
        "../envs/stacks.yml",
    log:
        "logs/demult_idx1pilot/idx1pilot.log",
    shell:
        "(process_radtags -i gzfastq --threads 10 --inline_null -1 {input.in1} -2 {input.in2} -o results/process_radtags/ -b {params.barcodes} -c -r -q --renz-1 {params.enz1}) 2> {log}"
