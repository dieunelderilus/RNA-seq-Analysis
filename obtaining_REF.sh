!#/bin/bash

# Downloading the reference genome of A. arabiensis from VectorBase
wget https://vectorbase.org/common/downloads/Current_Release/AarabiensisDongola/fasta/data/VectorBase-48_AarabiensisDongola_Genome.fasta

# Downloading the annotation file in gff format from VectorBase
wget https://vectorbase.org/common/downloads/Current_Release/AarabiensisDongola/gff/data/VectorBase-48_AarabiensisDongola.gff

# featureCount needs the annotation file as input in gtf format, let's convert gff to gtf  format using
/scicomp/home/qlk5/Desktop/important_programs/ExpressionAnalysis-ea-utils-bd148d4/clipper/gff2gtf VectorBase-48_AarabiensisDongola.gff > VectorBase-48_AarabiensisDongola.gtf 
