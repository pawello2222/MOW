library(readr)

loadData <- function(base_dir)
{
  data_frame <- loadCategory(base_dir, "Cryptography")
  data_frame <- rbind(data_frame,loadCategory(base_dir, "Electronics"))
  data_frame <- rbind(data_frame,loadCategory(base_dir, "Medicine"))
  data_frame <- rbind(data_frame,loadCategory(base_dir, "Space"))
}

loadCategory <- function(base_dir, category_name)
{
  current_dir <- paste(base_dir, 'Data/', category_name, "/", sep="")
  file_names=as.list(dir(path = current_dir,pattern="*", include.dirs = FALSE))
  
  data_frame <- NULL
  count <- 1000 #length(file_names)
  
  for(i in 1:count)
  {
    path <- paste(current_dir, file_names[[i]], sep="")
    contents_of_file <- read_file(path)
    
    if (i==1)
    {
      data_frame <- data.frame(contents_of_file, category_name, stringsAsFactors=FALSE)
    }
    else
    {
      data_frame <- rbind(data_frame,c(contents_of_file, category_name))
    }
  }
  
  colnames(data_frame)[1] <- "Text"
  colnames(data_frame)[2] <- "Category"
  
  return(data_frame)
}

