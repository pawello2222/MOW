### Packages
library(tm)
library(class)
library(stringr)
library(RTextTools)

### KNN classifier
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
  
  # Create DTM
  dtm <- DocumentTermMatrix(corpus)
  
  # Transform DTM to matrix to data frame
  mat.df <- as.data.frame(data.matrix(dtm), stringsAsfactors=FALSE)
  
  # Create training set
  mat.train <- mat.df[1:train_size,]
  
  # Create test set
  mat.test <- mat.df[(train_size+1):data_length,]
  
  # Create training set classifier
  data.train.cl <- data[1:train_size,2]
  
  # Train model and classify test set
  predictions <- knn(mat.train, mat.test, data.train.cl, 
                     k=1, l=0, prob=FALSE, use.all=FALSE)
  
  # Return predictions
  return(predictions)
}
