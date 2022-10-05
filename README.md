# CSF_CFDNA_SEQ
SNV/Indel/CNV calling for CSF liquid biopsies

#Download the repository
Download the folder "github_repo". This folder is your CSF_CFDNA_SEQ home directory. Scripts can be run from the sub-directory "CSF_CFDNA_SEQ". Results are produced in the github_repo/data/results section. Ressources and software needed by the respective scripts are stored in github_repo/reference or github_repo/software. In the reference section, manually install the following:
1. reference genome
2. funcotator_data_source

Both ressources can be obtained from the gatk ressource bundle or be provided upon request.

# Prepare the environment
All applications within this pipeline are dockerized. Therefore little adjustments of the users environment have to be taken.
1. Install Docker on your machine
2. Create the docker images used in the pipeline by running the following script: XXX
3. Install GNU parallel (XXX)

# Run the Scripts
In the directory github_repo/CSF_CFDNA_SEQ you will find the following Run Scripts:
1. Analyse_Paired_library.sh
2. Analyze_SINGEL
3. Analyse PAired sample
4. analyse single sample

These scripts combine all applications for an end to end workflow starting with raw bcl or de-multiplexed fastq files.

For analyzing MYD88_L265P mutational status, use the scripts provided in the directory github_repo/CSF_CFDNA_SEQ/MYD88
1. for library
2. for sample
