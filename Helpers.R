### Packages
library(readr)

### Helper functions
# Load data from all categories
loadData <- function(base_dir, data_size)
{
  data_frame <- loadCategory(base_dir, data_size, "Cryptography")
  data_frame <- rbind(data_frame,loadCategory(base_dir, data_size, "Electronics"))
  data_frame <- rbind(data_frame,loadCategory(base_dir, data_size, "Medicine"))
  data_frame <- rbind(data_frame,loadCategory(base_dir, data_size, "Space"))
}

# Load data from single category
loadCategory <- function(base_dir, data_size, category_name)
{
  current_dir <- paste(base_dir, 'Data/', category_name, "/", sep="")
  file_names=as.list(dir(path = current_dir,pattern="*", include.dirs = FALSE))
  
  data_frame <- NULL
  
  for(i in 1:data_size)
  {
    path <- paste(current_dir, file_names[[i]], sep="")
    contents_of_file <- read_file(path)

    if (i==1)
      data_frame <- data.frame(contents_of_file, category_name, stringsAsFactors=FALSE)
    else
      data_frame <- rbind(data_frame,c(contents_of_file, category_name))
  }
  
  colnames(data_frame)[1] <- "Text"
  colnames(data_frame)[2] <- "Category"
  
  return(data_frame)
}
