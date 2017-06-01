#Sources
source("DataLoader.R")

# Packages
library(RTextTools)
library(e1071)

library(readr)

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
    
    data_frame <- rbind(data_frame,c(contents_of_file, category_name))
  }
  
  return(data_frame)
}

base_dir <- "~/Documents/Projekty/MOW/"

data <- loadData("~/Documents/Projekty/MOW/")

matrix = create_matrix(data[,1], language="english", minDocFreq=3,
                       removeStopwords=TRUE, removeNumbers=TRUE, 
                       removePunctuation=TRUE, stripWhitespace=TRUE, 
                       toLower=TRUE, stemWords=TRUE)

container = create_container(matrix, as.numeric(as.factor(data[,2])),
                             trainSize=1:3900, virgin=FALSE)

model <- train_model(container,"SVM",kernel="linear",cost=1,gamma=0.5)

predMatrix <- create_matrix(data[3901:4000,1], originalMatrix=matrix)
predSize = length(data[3901:4000,1])
print(predSize)
predictionContainer <- create_container(predMatrix, labels=rep(0,predSize), 
                                        testSize=1:predSize, virgin=FALSE)
results <- classify_model(predictionContainer, model)
results

