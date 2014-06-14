corr<- function(directory, threshold = 0) {
  
  dir <- paste0("/home/ruben/R/", directory)
  setwd(dir)
  files <- list.files()
  
  my_vec <- vector('numeric')
  
  for (file in files)
  {
    # message("file:", file)
    curr_file <- read.csv(file)
    # message("current file: ", file)
    temp <- curr_file[!is.na(curr_file["sulfate"]) ,]
    my_complete_cases <- temp[!is.na(temp["nitrate"]) ,]
    # message("nr of rows: ",nrow(my_complete_cases))
    if (nrow(my_complete_cases) > threshold)
    {
       # message("processing file: ", file)
      x <- my_complete_cases[["sulfate"]]
      y <- my_complete_cases[["nitrate"]]
      correlation <- cor(x,y)
      my_vec <- c(my_vec, correlation)
    }
    

  }
   #message(files, "class files: ", class(files), "length files: ", length(files))
  my_vec
}