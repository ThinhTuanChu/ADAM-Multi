rm(list = ls()); cat("\014")   #Clear lists and console  

###input needed
nMarker <- 2000  #  60   # 

filename <- 'dmudatMLM.txt'
if (!file.exists(filename)) file.remove(filename)

### load functions & packages
filename <- paste0('C:/ThinhInDenmark/Rpreloadfuncs/',"BlupPreloadfunctions2.R")
if (!file.exists(filename)) filename <- paste0('/usr/home/qgg/chuthinh/adam/',"BlupPreloadfunctions2.R")
if (!file.exists(filename)) {  stop(paste('Error: The file',filename,'does not exists. This module is needed for',filename))}
source(filename)
#list of library packages required
temp1 <- c('data.table','readr') 			# c("readxl","plyr","ggplot2",'GA')
temp2 <- temp1 %in% rownames(installed.packages()) # Install packages not yet installed
if (any(temp2 == FALSE)) {
  install.packages(temp1[!temp2])}
#load packages
invisible(lapply(temp1, library, character.only = TRUE))

### reading data 
# dmudat
filename='dmudat'
if (!file.exists(filename)) {   stop(paste('Error: The file',filename,'does not exists.'))  }  # checking input file
  df<-tryCatch(read.table(filename, header = T), error=function(e) NULL)  # header = F if adam input changed
if (is.null(df)) {     stop(paste('Error: The file ',filename,' is empty.'))   }
dfpheno <- df
# genotype file
filename='marker.RawData'
if (!file.exists(filename)) {   stop(paste('Error: The file',filename,'does not exists.'))  }  # checking input file
dfgeno <- read_fwf(file=filename,fwf_widths(c(9,rep(1,nMarker)))) 

####### generate phenotype input file - dmudatMLM.txt ##################
df <- dfpheno
# Nothing, just reserve a place for editing phenotype file later
# write out the dataframe
write.table(df, file ='dmudatMLM.txt',col.names = F,row.names = F,quote = FALSE,na="-9999",sep =" ")

##### generate file  SOLkeeprecord.txt
df <- dfpheno
df$reqcol <- 1
write.table(df[,c('reqcol','Animal','trait1')], file ='SOLkeeprecord.txt',col.names = F,row.names = F,quote = FALSE,na="-9999",sep =" ")
