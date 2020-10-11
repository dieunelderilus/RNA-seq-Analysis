# the input data for this script could be found here :
#https://rpkgs.datanovia.com/ggpubr/reference/diff_express.html#examples

library(edgeR)
library(tidyr)
rawdata=read.delim('read_counts.txt', check.names=F, row.names=1)
info= read.delim('experimental_design.txt', check.names=F, row.names=1)
info <-info%>% drop_na()

dge=DGEList(rawdata,group= info$Condition)


##Filtering
keep=rowSums(cpm(dge) > 0) >= 1
dge=dge[keep, , keep.lib.sizes=F]

##Normalization
dge=calcNormFactors(dge, method='TMM')

# experimental design
design <- model.matrix(~dge$samples$group)
##Dispersions

dge=estimateDisp(dge, design)

#exper
##Test
dex=exactTest(dge, pair=c('Control','Treatment'))
summary(decideTests(dex))
summary(decideTestsDGE(dex, p=0.05, lfc=1))

#plot MA  (smear)
de=decideTestsDGE(dex, p=0.05, adjust='BH',lfc=1)
detags=rownames(dex)[as.logical(de)]
plotSmear(dex, de.tags=detags, 
          main='MA Plot for Count Data')
abline(h=c(-1,1), col='blue')
# otro MA plot (regular)
plotMD(dex)
pabline(h=c(-1, 1), col="blue")

# volcano plot

d1 <- dex$table

# add a column of NAs
d1$series <- "NAs"

# if log2Foldchange > 0.6 and pvalue < 0.05, set as "UP" 
d1$series[d1$logFC > 1 & d1$PValue < 0.01] <- "Up"
# if log2Foldchange < -0.6 and pvalue < 0.05, set as "Down"
d1$series[d1$logFC < -1 & d1$PValue < 0.01] <- "Down"

d1$series[d1$PValue  > 0.01] <- "NotSig"


# Re-plot but this time color the points with "diffexpressed"
p <- ggplot(data=d1, aes(x=logFC, y=-log10(PValue), col=series)) + geom_point() + theme_minimal()

p2 <- p+scale_color_manual(breaks = c("Down", "NotSig", "Up"),values=c("red", "blue", "green"))
# Add lines as before...
p2 <- p + geom_vline(xintercept=c(-1, 1), col="red") +
  scale_color_manual(values=c("red", "black", "blue", "grey"))

