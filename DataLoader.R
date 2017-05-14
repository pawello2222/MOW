library(readr)

loadData <- function()
{
  contents_of_file <- read_file("./Data/Space/Test")
  row <- c(contents_of_file, "Space")
  
  #should return data as matrix with headers
}