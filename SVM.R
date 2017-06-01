# Packages
library(RTextTools)
library(e1071)

classify_svm <- function(data, train_size)
{
  data_length <- length(data[,1])
  matrix <- create_matrix(data[,1], language="english", minDocFreq=3,
                         removeStopwords=TRUE, removeNumbers=TRUE, 
                         removePunctuation=TRUE, stripWhitespace=TRUE, 
                         toLower=TRUE, stemWords=TRUE)
  
  container <- create_container(matrix, as.numeric(as.factor(data[,2])),
                               trainSize=1:train_size, virgin=FALSE)
  
  model <- train_model(container,"SVM", kernel="linear", cost=1, gamma=0.5)
  
  predMatrix <- create_matrix(data[(train_size+1):data_length,1], originalMatrix=matrix)
  predSize <- length(data[(train_size+1):data_length,1])

  predictionContainer <- create_container(predMatrix, labels=rep(0,predSize), 
                                          testSize=1:predSize, virgin=FALSE)
  
  return(classify_model(predictionContainer, model))
}
