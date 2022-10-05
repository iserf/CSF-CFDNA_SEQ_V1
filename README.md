# CSF_CFDNA_SEQ
SNV/InDel/CNV calling for CSF liquid biopsies.

This pipeline was created to perform SNV, InDel and CNV calling from targeted sequencing data of cell-free DNA (cfDNA) isolated from cerebrospinal fluid (CSF). Libraries need to be prepared using the SureSelect XT HS2 DNA Reagent Kit (Agilent). The pipeline analyzes the target region of the neurooncology gene panel from the Institute of Neuropathology at Heidelberg Univeristy.
Further, a workflow to analyzed the presence of MYD88:p.L265P mutation of CSF cfDNA samples from suspected primary central nervous system lymphoma (PCNSL) is included. Libraries have to be prepared from a PCR amplicon using the SureSelect XT HS2 DNA Reagent Kit. Importantly, no target enrichment has to be performed, since MYD88 is not part of the neurooncology gene panel.

*Detailed wet lab protocols can be found in my MD thesis: XXX*

# Getting started

## Download the repository
Download the directory "github_repo" with all its sub-direcoties. This directory is your CSF_CFDNA_SEQ home directory (home_dir).

**IMPORTANT: The absolute file path ([absolute filepath]/github_repo) has to specified as the home_dir argument when running any script of this pipeline**

Scripts can be run from the sub-directory /github_repo/CSF_CFDNA_SEQ. Results are produced in the /github_repo/data/results section. Ressources and software needed by the respective scripts are stored within github_repo/reference or github_repo/software. Due to the large size of several GB, the following ressources have to be manually installed within github_repo/reference section:

1. hg38 reference fasta within github_repo/reference/hg38/v0/
2. gatk Funcotator data source within github_repo/reference/funcotator_dat_source_in_use

Both ressources can be obtained from the gatk ressource bundle or be provided upon request. By default, both directories above contain a missing_ressources.txt file where the neccessary ressources are mentioned.

## Prepare the environment
All applications within this pipeline are dockerized. Therefore, only little adjustments of the users environment have to be taken.

1. Install Docker on your machine
2. Install GNU parallel (e.g. sudo apt-get install parallel)
3. Create the docker images used in the pipeline by running the following script: /github_repo/CSF_CFDNA_SEQ/docker_images/prepare_environment.sh

# SNV/InDel/CNV Calling Pipeline

## Pipeline Overview
Briefly, the following steps and tools are applied within this pipeline:

1. De-Multiplexing (bcl-convert)*
2. Read trimming (AGeNT Trimmer)
3. Alignment to hg38 reference genome (bwa_mem2)
4. Deduplication using duplex molecular barcodes (AGeNT CReAK, gatk bqsr)
5. Fingerprint comparison of CSF cfDNA sample and matching germline control (gatk CrosscheckFingerprints)**
6. SNV/ InDel Variant Calling (Mutect2, VarScan2, Strelka2, VarDict, Scalpel, LoFreq, MuSE** from lethalfang/somaticseq)
7. SNV/ InDel Variant Calling (Octopus)
8. Classification of called variants with a pre-trained classifier optimized for targeted sequencing of CSF cfDNA samples with the neurooncology gene panel (SomaticSeq) 
9. Variant calling at specific positions (hotspot mutations, different to call regions) specified in /home_dir/reference/bed/special_positions.tsv (bcftools mpileup)
10. Annotation of the calls (gatk Funcotator)
11. Creation of report (SNV/InDel calls + Special Positions) (Python)
12. CNV calling (cnvkit)
13. Sequencing QC (fastQC, multiQC)
14. Sequencing statistics (gatk FlagStatSpark, gatk CollectHsMetrics)

* Not run when running Analyze_Paired_Sample.sh or Analyze_Single_Sample.sh
** Not included when running the pipeline in SINGLE mode (without matching germline control).

## Run the Scripts
In the directory github_repo/CSF_CFDNA_SEQ you will find Scripts which combine all applications for an end to end workflow starting with raw bcl or de-multiplexed fastq files:

1. Analyse_Paired_library.sh: For analyzing a NGS library starting with raw bcl files. Library contains CSF cfDNA samples and matching germline control samples.
2. Analyze_Single_library.sh: For analyzing a NGS library starting with raw bcl files. Library contains only CSF cfDNA samples.
3. Analyze_Mixed_library.sh: For analyzing a NGS library starting with raw bcl files. Library contains CSF cfDNA samples with and without matching germline control samples.
4. Analyze_Paired_Sample.sh: For analyzing a matched CSF cfDNA and germline control sample pair. Starting from demultiplexed fastq files.
4. Analyze_Single_Sample.sh: For analyzing a CSF cfDNA sample without matching germline control. Starting from demultiplexed fastq files.

The recquired data structure/ arguments are described within the header of each script.

# MYD88:p.L265P Calling Pipeline
## Pipeline Overview
For analyzing MYD88:p.L265P mutational status, the following steps and tools are applied:

1. De-Multiplexing (bcl-convert)*
2. Read trimming (AGeNT Trimmer)
3. Alignment to hg38 reference genome (bwa_mem2)
4. Deduplication using duplex molecular barcodes (AGeNT CReAK, gatk bqsr)
5. Variant calling at chr3:38141135 - chr3:38141165 (bcftools mpileup)
6. Sequencing QC (fastQC, multiQC)
7. Sequencing statistics (gatk FlagStatSpark, gatk CollectHsMetrics, gatk CollectInsertSizeMetrics)

* Not run when running Analyze_MYD88_Sample.sh

## Run the Scripts
In the directory github_repo/CSF_CFDNA_SEQ/MYD88 you will find Scripts which combine all applications for an end to end workflow starting with raw bcl or de-multiplexed fastq files:

1. Analyse_MYD88_library.sh: For analyzing a NGS library starting with raw bcl files. Library contains only CSF cfDNA samples.
2. Analyze_MYD88_Sample.sh: For analyzing a CSF cfDNA sample without matching germline control. Starting from demultiplexed fastq files.
