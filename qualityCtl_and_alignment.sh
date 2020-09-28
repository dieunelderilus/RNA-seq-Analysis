#!/bin/bash -l

### Pipeline for analysis of one RNA-seq data sample, from data filtering to alignment. The output generated from this bash script could be used directly as input in "featureCount"
### before proceeding to quality filtering, it is recommended to evaluated the data quality  with fastQC

## qsub parameters
#$ -cwd
#$ -m ae
#$ -M qlk5@cdc.gov
#$ -q all.q

## load the modules
module load fastp
module load subread
module load samtools


## Quality filtering using fastp. Note that this command line could be modified based on the quality of the raw reads as revealed by the FastqC results
fastp \
--in1 SEK-1_S3_l1l2_R1.fastq \
--in2 SEK-1_S3_l1l2_R2.fastq \
--out1 SEK-1_S3_l1l2_fastp_R1.fastq \
--out2 SEK-1_S3_l1l2_fastp_R2.fastq \
-q 20 \
-h SEK-1_S3_l1l2_fastp.html \
-l 25 \
--trim_poly_g \
--trim_poly_x


## Aligning the filtered reads against the reference genome
subjunc -T 4 -M 5 -d 50 -D 1500 -r SEK-1_S3_l1l2_fastp_R1.fastq -R SEK-1_S3_l1l2_fastp_R2.fastq -i VectorBase-48_AarabiensisDongola_Genome_index -o SEK-1_S3_l1l2.bam

## Getting the summary statistics about the alignment
samtools flagstat SEK-1_S3_l1l2.bam > SEK-1_S3_l1l2.bam.summary.txt


#filter bam to remove MAPQ<10 (-q 10) and unmapped reads (-F 4)
samtools view -b -q 10 -F 4 SEK-1_S3_l1l2.bam -o SEK-1_S3_l1l2_mq10.bam -@ 16

#sorting the filtered *bam file
samtools sort SEK-1_S3_l1l2_mq10.bam -o SEK-1_S3_l1l2_mq10.srt.bam -@ 16

