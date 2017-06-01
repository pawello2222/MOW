# Packages
library(tm)
library(class)
library(stringr)
library(RTextTools)

# KNN classifier
classify_knn <- function(data, train_size)
{
  data_length <- length(data[,1])
  
  # Create corpus
  corpus <- Corpus(VectorSource(data$Text))
  
  # Clean corpus
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, str_replace_all,pattern = "<.*?>", replacement=" ")
  corpus <- tm_map(corpus, str_replace_all,pattern ="\\=", replacement=" ")
  corpus <- tm_map(corpus, str_replace_all,pattern = "[[:punct:]]", replacement=" ")
  corpus <- tm_map(corpus, removeWords, words=stopwords("en"))
  corpus <- tm_map(corpus, tolower)
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, stemDocument)
  
  # Create dtm
  dtm <- DocumentTermMatrix(corpus)
  
  # Transform dtm to matrix to data frame
  mat.df <- as.data.frame(data.matrix(dtm), stringsAsfactors=FALSE)
  
  mat.train <- mat.df[1:train_size,]
  mat.test <- mat.df[(train_size+1):data_length,]
  
  data.train.cl <- data[1:train_size,2]
  data.test.cl <- data[(train_size+1):data_length,2]
  
  # Create model: training set, test set, training set classifier
  knn.pred <- knn(mat.train, mat.test, data.train.cl, 
                  k=1, l=0, prob=FALSE, use.all=FALSE)
  
  return(knn.pred)
}
