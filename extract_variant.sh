#Autor: Dieunel Derilus
## list of commandlines to extract  individual variants from *frq file (output of vcftools) for anopheles gambiae. 
#the extraction will be done on the chromosome 2L were the VGSC gene is located

# extract the chromsome "AgamP4_2L"
AgamP4_2L
for i in `ls *frq`; do grep 'AgamP4_2L' $i > AgamP4_2L_$i; done
# extract the SNP corresponding to one variant (ex: snp of the vriant L995S located at the 2422651) in all the samples
grep -w '2422651' AgamP4_2L_*frq

# extract the SNP corresponding to one variant (ex: snp of the vriant L995F located at the 2422651) in all the samples
grep -w '2422652' AgamP4_2L_*frq

# extract all the variant in the vgsc gene for one frq file. THe variant position are copied in the input file (vgsc.txt)
 grep -w -f vgsc.txt AgamP4_2L_BN_l112.frq | sort -k2,2

#extract all the variant in the vgsc gene for one frq file. THe variant position are copied in the input file ('vgsc.txt')
grep -w -f vgsc.txt AgamP4_2L_*_l112.frq | sort -k1,1
