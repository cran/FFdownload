## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "VIGNETTE-"
)


## ----setup, eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE---------------
library(FFdownload)
outd <- paste0(tempdir(),"/",format(Sys.time(), "%F_%H-%M"))
outfile <- paste0(outd,"FFData_xts.RData")
listfile <- paste0(outd,"FFList.txt")

## ----setup2, eval=FALSE, echo=TRUE--------------------------------------------
#  library(FFdownload)
#  outd <- paste0("data/",format(Sys.time(), "%F_%H-%M"))
#  outfile <- paste0(outd,"FFData_xts.RData")
#  listfile <- paste0(outd,"FFList.txt")

## ----xts_list_save------------------------------------------------------------
FFdownload(exclude_daily=TRUE,download=FALSE,download_only=TRUE,listsave=listfile)
read.delim(listfile,sep = ",")[c(1:4,73:74),]

## ----xts_download-------------------------------------------------------------
inputlist <- c("F-F_Research_Data_Factors_CSV","F-F_Momentum_Factor_CSV")
FFdownload(exclude_daily=TRUE, tempd=outd, download=TRUE, download_only=TRUE, inputlist=inputlist)
list.files(outd)

## ----xts_processing-----------------------------------------------------------
FFdownload(exclude_daily=TRUE, tempd=outd, download=FALSE, download_only=FALSE, inputlist=inputlist, output_file = outfile)

## ----xts_load-----------------------------------------------------------------
load(outfile)
ls.str(FFdata)

## ----xts_process, eval=FALSE, echo=TRUE---------------------------------------
#  monthly <- do.call(merge, lapply(FFdata, function(i) i$monthly$Temp2))
#  monthly_1960 <- na.omit(monthly)["1963/"]
#  monthly_returns <- cumprod(1 + monthly_1960/100) - 1
#  plot(monthly_returns)

## ----xts_process2, eval=TRUE, echo=FALSE, out.width="100%", fig.width=8, fig.height=4----
monthly <- do.call(merge, lapply(FFdata, function(i) i$monthly$Temp2))
monthly_1960 <- na.omit(monthly)["1963/"]
monthly_returns <- cumprod(1 + monthly_1960/100) - 1
plot(monthly_returns, col = viridis::viridis(5, direction = -1), legend.loc="topleft", lwd=2, main="Fama-French & Carhart Factor Wealth Index")

