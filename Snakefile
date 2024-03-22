configfile: "config/pconcolor.yaml"

include: "workflow/rules/common.smk"

include: "workflow/rules/clone_filter.smk"
#include: "workflow/rules/cutadapt.smk"
include: "workflow/rules/process_radtags.smk"
include: "workflow/rules/bwa_index.smk"
include: "workflow/rules/bwa_map.smk"
include: "workflow/rules/gstacks.smk"
include: "workflow/rules/populations.smk"
