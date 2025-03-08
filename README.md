## Table of Contents

- [Adaptive Immune Receptor Repertoire analysis](#adaptive-immune-receptor-repertoire-analysis)
  - [Setup](#setup)
  - [Test results](#test-results)

# Adaptive Immune Receptor Repertoire analysis

[nf-core/airrflow](https://nf-co.re/airrflow/4.2.0/):

> nf-core/airrflow is a bioinformatics best-practice pipeline to analyze B-cell or T-cell repertoire sequencing data. It makes use of the Immcantation toolset. The input data can be targeted amplicon bulk sequencing data of the V, D, J and C regions of the B/T-cell receptor with multiplex PCR or 5’ RACE protocol, single-cell VDJ sequencing using the 10xGenomics libraries, or assembled reads (bulk or single-cell).
>
> nf-core/airrflow allows the end-to-end processing of BCR and TCR bulk and single cell targeted sequencing data. Several protocols are supported, please see the usage documentation for more details on the supported protocols. The pipeline has been certified as AIRR compliant by the AIRR community, which means that it is compatible with downstream analysis tools also supporting this format.

## Setup

1. Install `nf-core/tools`

```console
pip install --upgrade nf-core
nf-core --version
```
```
                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 3.2.0 - https://nf-co.re


nf-core, version 3.2.0
```

2. Find and download `nf-core/airrflow`

```console
nf-core pipelines list | grep airrflow
```
```
                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 3.2.0 - https://nf-co.re


│ airrflow                  │    59 │          4.2.0 │  3 months ago │           - │ -                    │
```

Download.

```console
export NXF_SINGULARITY_CACHEDIR=/data/nxf_singularity
nf-core pipelines download --revision 4.2.0 --outdir /data/nf-core/airrflow --compress none --container-system singularity --parallel-downloads 4 airrflow
# select amend
```

3. Test

```console
nextflow run /data/nf-core/airrflow/4_2_0/main.nf -profile test,singularity --outdir /data/airrflow_test
```
```
-[nf-core/airrflow] Pipeline completed successfully-
Completed at: 08-Mar-2025 16:47:51
Duration    : 10m 40s
CPU hours   : 0.7
Succeeded   : 221
```

## Test results

Results were written to `/data/airrflow_test`. See the [nf-core/airrflow output page](https://nf-co.re/airrflow/4.2.0/docs/output/) for more information.

```console
tree -L 1 --charset ascii /data/airrflow_test
```
```
/data/airrflow_test
|-- Airrflow_report.html
|-- clonal_analysis
|-- fastp
|-- fastqc
|-- multiqc
|-- parsed_logs
|-- pipeline_info
|-- presto
|-- qc-filtering
|-- repertoire_comparison
|-- report_file_size
`-- vdj_annotation
```


