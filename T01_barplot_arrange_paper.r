

### import library

library(ggplot2)
library(tidyverse) 
library(ggpubr)
library(grid)
library(gridExtra)

### clean the evrs

rm(list = ls())

list.files("data", full.names = T)

plot_list <- readRDS("data/barplot_list.rds" )



#### extract the common legend 

##### #extract legend

g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}



mylegend<-g_legend(plot_list[[1]]) ## tabke the first one as common legend 



p_legend <- ggarrange(mylegend ) 


print(p_legend )

### arrange the plots and legend 


barplot_list <- vector( "list", length = 6L)

barplot_list

barplot_list[[1]] <- plot_list[[1]]


barplot_list[[2]] <- plot_list[[2]]

barplot_list[[3]] <- plot_list[[3]]

barplot_list[[4]] <- p_legend   ### insert the legend here 
barplot_list[[5]] <- plot_list[[4]]
barplot_list[[6]] <- plot_list[[5]]







### arrange the order in the barplots 



ggarrange(plotlist=barplot_list,
          ncol =2,
          nrow = 3,
          #widths = c(1, 2) ,
          legend = "none",
          #legend.grob = get_legend(plot_list[[5]]),
          common.legend = T,
          labels =as_factor(c( "A", "", "","", "B", "" ) )
)


############ export figure 

Plot_final <-
  
  ggarrange(plotlist=barplot_list,
            ncol =2,
            nrow = 3,
            #widths = c(1, 2) ,
            legend = "none",
            #legend.grob = get_legend(plot_list[[5]]),
            common.legend = T,
            labels =as_factor(c( "A", "", "","", "B", "" ) )
  )


#### save figure 

#dir.create("figures")

png("figures/barplot_72to96_final.png",
    units = "in",
    width =8,
    height =10,
    res =600)
grid.draw(Plot_final)
dev.off()




