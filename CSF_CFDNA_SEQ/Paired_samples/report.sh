#!/bin/bash

#Input arguments
ID_T=$1
home_dir=$2

#Directories
work_dir=$home_dir/data/results/${ID_T}/variants/somaticseq
OUT_DIR=$work_dir/report
mkdir -p $OUT_DIR

#Files
SNV=$work_dir/classify_variants/${ID_T}.SSeq.Classified.sSNV.annotated.maf
INDEL=$work_dir/classify_variants/${ID_T}.SSeq.Classified.sINDEL.annotated.maf
special_positions_raw=$work_dir/special_positions/${ID_T}_special_positions.raw_bam.annotated.maf
special_positions_deduped=$work_dir/special_positions/${ID_T}_special_positions.DUPLEX_bam.annotated.maf

#intersect sites
report=$OUT_DIR/${ID_T}.CSF_CFDNA_SEQ.report.xlsx

##Script##
#create excel report
docker run --rm -v ${home_dir}:${home_dir} -u $UID --memory 100G 31071993/CSF_CFDNA_SEQ:SNV_INDEL_report /bin/bash -c \
"python /mydata/create_report.py $SNV $INDEL $special_positions_raw $special_positions_deduped $report"
