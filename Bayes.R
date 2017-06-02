### Packages
library(RTextTools)
library(e1071)

### Bayes classifier
classify_bayes <- function(data, train_size)
{
  data_length <- length(data[,1])
  
  # Create matrix and additionally remove unnecessary words, characters etc.
  matrix <- create_matrix(data[,1], language="english", minDocFreq=3,
                         removeStopwords=TRUE, removeNumbers=TRUE, 
                         removePunctuation=TRUE, stripWhitespace=TRUE, 
                         toLower=TRUE, stemWords=TRUE) 
  
  mat <- as.matrix(matrix)
  
  # Create training set
  mat.train <- mat[1:train_size,]
  
  # Create test set
  mat.test <- mat[(train_size+1):data_length,]
  
  # Create training set classifier
  data.train.cl <- data[1:train_size,2]
  
  # Create model
  classifier <- naiveBayes(mat.train, as.factor(data.train.cl))
  
  # Return predictions
  return(predict(classifier, mat.test))
}
