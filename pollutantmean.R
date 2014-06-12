pollutantmean <- function(directory, pollutant, id = 1:332) {
setwd(directory)

message(pollutant)
files <- vector()

for (i in id)
{
  nuls <- paste0(rep("0",(3-nchar(id[i]))),collapse='')
  pat <- paste0(nuls, id[i],".csv", collapse='')
  message("looking for files:", pat)
  found <- list.files(path=".",pattern=pat)
  files <- c(files,found)
}
message(files)

data = lapply(files, read.csv)

}