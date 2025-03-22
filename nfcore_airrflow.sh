#!/usr/bin/env bash

set -euo pipefail

export NXF_SINGULARITY_CACHEDIR=/data/nxf_singularity

if [[ ! -e airr_rearrangement.tsv ]]; then
   wget -q https://davetang.org/file/HumanB_Cell/outs/airr_rearrangement.tsv
fi

nextflow run /data/nf-core/airrflow/4_2_0/main.nf \
   -resume \
   -profile singularity \
   --input assembled_samplesheet.tsv \
   --mode assembled \
   --outdir results
