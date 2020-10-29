
<!-- README.md is generated from README.Rmd. Please edit that file -->

# FFdownload <a href='https://github.com/sstoeckl/FFdownload'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start --> [![Travis build
status](https://travis-ci.org/sstoeckl/ffdownload.svg?branch=master)](https://travis-ci.org/sstoeckl/ffdownload)
<!-- badges: end --> <!-- badges: start --> [![CRAN
status](https://www.r-pkg.org/badges/version/FFdownload)](https://CRAN.R-project.org/package=FFdownload)
<!-- badges: end -->

`R` Code to download Datasets from [Kenneth French’s famous
website](http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/data_library.html).

## Motivation

One often needs those datasets for further empirical work and it is a
tedious effort to download the (zipped) csv, open and then manually
separate the contained datasets. This package downloads them
automatically, and converts them to a list of xts-objects that contain
all the information from the csv-files.

## Contributors

Original code from MasimovR <https://github.com/MasimovR/>. Was then
heavily redacted by me.

## Installation

You can install FFdownload from CRAN with

``` r
install.packages("FFdownload")
```

or directly from github with:

``` r
# install.packages("devtools")
devtools::install_github("sstoeckl/FFdownload")
```

## Example

``` r
library(FFdownload)
tempf <- tempfile(fileext = ".RData"); tempd <- tempdir(); temptxt <- tempfile(fileext = ".txt")
# Example 1: Use FFdownload to get a list of all monthly zip-files. Save that list as temptxt.
FFdownload(exclude_daily=TRUE,download=FALSE,download_only=TRUE,listsave=temptxt)
# set vector with only files to download (we tray a fuzzyjoin, so "Momentum" should be enough to get the Momentum Factor)
inputlist <- c("F-F_Research_Data_Factors","F-F_Momentum_Factor","F-F_ST_Reversal_Factor","F-F_LT_Reversal_Factor")
# Now process only these files if they can be matched (download only)
FFdownload(exclude_daily=TRUE,tempdir=tempd,download=TRUE,download_only=TRUE,inputlist=inputlist)
# Then process all the downloaded files
FFdownload(output_file = tempf, exclude_daily=TRUE,tempdir=tempd,download=FALSE,download_only=FALSE,inputlist=inputlist)
load(tempf); FFdownload$`x_F-F_Momentum_Factor`$monthly$Temp2[1:10]
# Example 2: Download all non-daily files and process them
tempf2 <- tempfile(fileext = ".RData"); tempd2 <- tempdir()
FFdownload(output_file = tempf2,tempdir = tempd2,exclude_daily = TRUE, download = TRUE, download_only=FALSE, listsave=temptxt)
load(tempf2)
FFdownload$x_25_Portfolios_5x5$monthly$average_value_weighted_returns
```
