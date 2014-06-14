complete<- function(directory, id = 1:332) {
  
  dir <- paste0("/home/ruben/R/", directory)
  setwd(dir)
  
  my_df <-data.frame(row.names=c("id","nobs"))
  
  for (i in id)
  {
    message("i:", i)
    nuls <- paste0(rep("0",(3-nchar(i))),collapse='')
    pat <- paste0(nuls, i,".csv", collapse='')
    message("looking for files:", pat)
    found <- list.files(path=".",pattern=pat)
    curr_file <- read.csv(found)
    message("current file: ", found)
    temp <- curr_file[!is.na(curr_file["sulfate"]) ,]
    my_complete_cases <- temp[!is.na(temp["nitrate"]) ,]
    message("nr of rows: ",nrow(my_complete_cases))
    my_df <- rbind(my_df, data.frame(id=i, nobs=nrow(my_complete_cases))) 
  }
   #message(files, "class files: ", class(files), "length files: ", length(files))
  my_df
}