pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  polls <- c("sulfate","nitrate")
  if(!(pollutant %in% polls))
  {
    stop("wrong pollant given")
  }
dir <- paste0("/home/ruben/R/", directory)
setwd(dir)

files <- vector()

for (i in id)
{
  nuls <- paste0(rep("0",(3-nchar(id[i]))),collapse='')
  pat <- paste0(nuls, id[i],".csv", collapse='')
  # message("looking for files:", pat)
  found <- list.files(path=".",pattern=pat)
  files <- c(files,found)
}
# message(files, "class files: ", class(files), "length files: ", length(files))

my_df <-data.frame()

for (file in files){
  my_df <- rbind(my_df, read.csv(file )  )
}
mean(my_df[!is.na(my_df[pollutant]),pollutant ])

}
