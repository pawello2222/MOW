# Packages
library(RTextTools)
library(e1071)

classify_bayes <- function(data, train_size)
{
  data_length <- length(data[,1])
  matrix <- create_matrix(data[,1], language="english", minDocFreq=3,
                         removeStopwords=TRUE, removeNumbers=TRUE, 
                         removePunctuation=TRUE, stripWhitespace=TRUE, 
                         toLower=TRUE, stemWords=TRUE) 
  
  mat <- as.matrix(matrix)
  
  mat.train <- mat[1:train_size,]
  mat.test <- mat[(train_size+1):data_length,]
  
  data.train.cl <- data[1:train_size,2]
  data.test.cl <- data[(train_size+1):data_length,2]
  
  classifier <- naiveBayes(mat.train, as.factor(data.train.cl) )
  
  return(predict(classifier, mat.test))
}
