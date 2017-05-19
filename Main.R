library(RTextTools)
source("DataLoader.R")

#TODO: is base_dir necessary?
processData <- function(base_dir)
{
  data <- loadData(base_dir)
  
  dataMatrix <- create_matrix(data["Text"], language="english", 
                              minWordLength=3, maxWordLength=Inf, 
                              removeNumbers=TRUE, removePunctuation=TRUE, 
                              removeSparseTerms=0, removeStopwords=TRUE,
                              stemWords=FALSE, stripWhitespace=TRUE, toLower=TRUE)
  
  container <- create_container(dataMatrix, data$Category, trainSize=1:100, virgin=FALSE)
  model <- train_model(container, "SVM")
  
  predictionData <- list("electronics", "space ship blue air planet", "health")
  predictionMatrix <- create_matrix(predictionData, originalMatrix=dataMatrix)
  
  predictionSize = length(predictionData)
  predictionContainer <- create_container(predictionMatrix, labels=rep(0,predictionSize), 
                                          testSize=1:predictionSize, virgin=FALSE)
  
  results <- classify_model(predictionContainer, model)
}

print(processData("~/Documents/Projekty/MOW/"))
