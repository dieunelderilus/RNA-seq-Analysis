#!/bin/bash -l

##  the qsub parameters
#$ -cwd
#$ -m ae
#$ -M qlk5@cdc.gov
#$ -q all.q

#load module
ml subread

#generating a feature count table for all the srt.bam files provided  as input here
featureCounts \
-T 16 \
-s 1 \
-p -B -C -Q 10 \
--largestOverlap --minOverlap 1 \
-t exon -g transcript_id \
-a VectorBase-48_AarabiensisDongola.gtf \
-o Aarab.sense.count_ft1.txt \
CON-4_S9_l1l2_subj.mq10.srt.bam \
CON-5_S8_l1l2_subj.mq10.srt.bam \
CON-6_S7_l1l2_subj.mq10.srt.bam \
PERM-1_S6_l1l2_subj.mq10.srt.bam \
PERM-2_S5_l1l2_subj.mq10.srt.bam \
PERM-3_S4_l1l2_subj.mq10.srt.bam \
SEK-1_S3_l1l2_subj.mq10.srt.bam \
SEK-2_S2_l1l2_subj.mq10.srt.bam \
SEK-4_S1_l1l2_subj.mq10.srt.bam
