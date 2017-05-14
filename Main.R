library(RTextTools)

processData <- function(data)
{
  dataMatrix <- create_matrix(data["Text"])
  
  #container <- create_container(dataMatrix, data$Category, trainSize=1:11, virgin=FALSE)
  #model <- train_model(container, "SVM", kernel="linear", cost=1)
}