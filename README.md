## Table of Contents

- [Adaptive Immune Receptor Repertoire analysis](#adaptive-immune-receptor-repertoire-analysis)
  - [Setup](#setup)
  - [Test results](#test-results)
  - [Input samplesheet](#input-samplesheet)
    - [Bulk](#bulk)
    - [Single cell](#single-cell)

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

## Input samplesheet

### Bulk

The [required input file](https://nf-co.re/airrflow/usage#fastq-input-samplesheet-bulk-airr-sequencing) for processing raw BCR or TCR bulk targeted sequencing data is a sample sheet in TSV format (tab separated). The following columns are required:

* `sample_id`
* `filename_R1`
* `filename_R2`
* `subject_id`
* `species`
* `tissue`
* `pcr_target_locus`
* `single_cell`
* `sex`
* `age`
* `biomaterial_provider`

| sample_id | filename_R1                     | filename_R2                     | filename_I1                     | subject_id | species | pcr_target_locus | tissue | sex    | age | biomaterial_provider | single_cell | intervention   | collection_time_point_relative | cell_subset  |
| -         | -                               | -                               | -                               | -          | -       | -                | -      | -      | -   | -                    | -           | -              | -                              | -            |
| sample01  | sample1_S8_L001_R1_001.fastq.gz | sample1_S8_L001_R2_001.fastq.gz | sample1_S8_L001_I1_001.fastq.gz | Subject02  | human   | IG               | blood  | NA     | 53  | sequencing_facility  | FALSE       | Drug_treatment | Baseline                       | plasmablasts |
| sample02  | sample2_S8_L001_R1_001.fastq.gz | sample2_S8_L001_R2_001.fastq.gz | sample2_S8_L001_I1_001.fastq.gz | Subject02  | human   | TR               | blood  | female | 78  | sequencing_facility  | FALSE       | Drug_treatment | Baseline                       | plasmablasts |

### Single cell

The [required input file](https://nf-co.re/airrflow/usage#fastq-input-samplesheet-single-cell-sequencing) for processing raw BCR or TCR single cell targeted sequencing data is a sample sheet in TSV format (tab separated). The columns are required:

* `sample_id`
* `filename_R1`
* `filename_R2`
* `subject_id`
* `species`
* `tissue`
* `pcr_target_locus`
* `single_cell`
* `sex`
* `age`
* `biomaterial_provider`

Any other columns you add will be available in the final repertoire file as extra metadata fields. You can refer to the bulk fastq input section for documentation on the individual columns. An example samplesheet is:

| sample_id | filename_R1                      | filename_R2                      | subject_id | species | pcr_target_locus | tissue | sex    | age | biomaterial_provider | single_cell |
| -         | -                                | -                                | -          | -       | -                | -      | -      | -   | -                    | -           |
| sample01  | sample01_S1_L001_R1_001.fastq.gz | sample01_S1_L001_R2_001.fastq.gz | Subject02  | human   | IG               | blood  | NA     | 53  | sequencing_facility  | TRUE        |
| sample02  | sample02_S1_L001_R1_001.fastq.gz | sample02_S1_L001_R2_001.fastq.gz | Subject02  | human   | TR               | blood  | female | 78  | sequencing_facility  | TRUE        |


FASTQ files must conform with the 10x Genomics Cell Ranger naming conventions with the same sample name as provided in the `sample_id` column:

```
>**[SAMPLE-NAME] S[CHIP-NUMBER]_ L00[LANE-NUMBER]_[R1/R2]_001.fastq.gz**
```

Read type is one of

* I1: Sample index read (optional)
* I2: Sample index read (optional)
* R1: Read 1
* R2: Read 2

It is possible to provide several FASTQ files per sample (e.g. sequenced over different chips or lanes). In this case the different FASTQ files per sample will be provided to the same Cell Ranger process. These rows should then have an identical `sample_id` field.

