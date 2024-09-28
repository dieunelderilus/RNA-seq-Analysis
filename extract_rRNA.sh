# how to extract rRNA from RNA-seq using sortmerna



# Load the module for the version of blast we will use
ml SortMeRNA
db=~/Desktop/Dieunel_analysis/CRID_data/230505_A01000_0318_AHVLGJDRX2_MAC16657/fastp_all/sortmerna_run/index

sortmerna --log \
--ref $db/silva-arc-23s-id98.fasta,$db/silva-arc-23s-id98.idx \
--ref $db/silva-bac-23s-id98.fasta,$db/silva-bac-23s-id98.idx \
--ref $db/silva-euk-28s-id98.fasta,$db/silva-euk-28s-id98.idx \
--ref $db/silva-arc-16s-id95.fasta,$db/silva-arc-16s-id95.idx \
--ref $db/silva-bac-16s-id90.fasta,$db/silva-bac-16s-id90.idx \
--ref $db/silva-euk-18s-id95.fasta,$db/silva-euk-18s-id95.idx \
--reads ../KNWR_01_S10_fastp_R1.fastq.gz --reads ../KNWR_01_S10_fastp_R2.fastq.gz -a $NSLOTS \
--aligned rRNA_KNWR_01_S10_fastp_ros_R3_S21 --fastx   --other other_KNWR_01_S10  --print_all_reads
