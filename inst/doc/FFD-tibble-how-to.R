## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "VIGNETTE-"
)

## ----setup, eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE---------------
library(FFdownload)
library(dplyr)
library(ggplot2)
library(tidyr)
outd <- paste0(tempdir(),"/",format(Sys.time(), "%F_%H-%M"))
outfile <- paste0(outd,"FFData_xts.RData")

## ----setup2, eval=FALSE, echo=TRUE--------------------------------------------
#  library(FFdownload)
#  library(tidyverse)
#  outd <- paste0("data/",format(Sys.time(), "%F_%H-%M"))
#  outfile <- paste0(outd,"FFData_xts.RData")

## ----tbl_all------------------------------------------------------------------
inputlist <- c("F-F_Research_Data_Factors_CSV","F-F_Momentum_Factor_CSV")
FFdownload(exclude_daily=TRUE, tempd=outd, download=TRUE, download_only=FALSE, inputlist=inputlist, output_file = outfile, format = "tibble")

## ----tbl_load-----------------------------------------------------------------
load(outfile)
ls.str(FFdata)

## ----tbl_check----------------------------------------------------------------
str(FFdata$`x_F-F_Research_Data_Factors`$monthly$Temp2)

## ----tbl_merge----------------------------------------------------------------
FFfour <- FFdata$`x_F-F_Research_Data_Factors`$monthly$Temp2 %>% 
  left_join(FFdata$`x_F-F_Momentum_Factor`$monthly$Temp2 ,by="date") 
FFfour %>% head()

## ----FFFourPic, out.width="100%", fig.width=8, fig.height=4-------------------
FFfour %>% 
  pivot_longer(Mkt.RF:Mom,names_to="FFVar",values_to="FFret") %>% 
  mutate(FFret=FFret/100,date=as.Date(date)) %>% # divide returns by 100
  filter(date>="1960-01-01",!FFVar=="RF") %>% group_by(FFVar) %>% 
  arrange(FFVar,date) %>%
  mutate(FFret=ifelse(date=="1960-01-01",1,FFret),FFretv=cumprod(1+FFret)-1) %>% 
  ggplot(aes(x=date,y=FFretv,col=FFVar,type=FFVar)) + geom_line(lwd=1.2) + scale_y_log10() +
  labs(title="FF5 Factors plus Momentum", subtitle="Cumulative wealth plots",ylab="cum. returns") + 
  scale_colour_viridis_d("FFvar") +
  theme_bw() + theme(legend.position="bottom")

