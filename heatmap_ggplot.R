#http://www.sthda.com/english/wiki/ggplot2-quick-correlation-matrix-heatmap-r-software-and-data-visualization
library(reshape2)
library(ggplot2)
# core
c=read.csv("core_gene.csv", check.names = F)
c1<- melt(c)
ggplot(data = c1, aes(y=Geneid, x=variable, fill=value)) + 
  geom_tile(color = "black") +coord_fixed()+
  scale_fill_gradient(low = "white",high = "red4") +  
  theme(axis.text.x = element_text(size = 8,color="black",angle=90),axis.text.y = element_text(size = 9,color="black"))+
  theme(axis.text.y = element_text(size = 8))
