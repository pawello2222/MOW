#Sources
source("DataLoader.R")

# Packages
library(RTextTools)

data <- loadData("~/Documents/Projekty/MOW/")

matrix = create_matrix(data[,1], language="english", minDocFreq=3,
                       removeStopwords=TRUE, removeNumbers=TRUE, 
                       removePunctuation=TRUE, stripWhitespace=TRUE, 
                       toLower=TRUE, stemWords=TRUE) 

mat = as.matrix(matrix)

mat.train = mat[1:4000,]
mat.test = mat[1:4000,]

data.train.cl = data[1:4000, 2]
data.test.cl = data[1:4000, 2]

classifier = naiveBayes(mat.train, as.factor(data.train.cl) )

predicted = predict(classifier, mat.test)
conf.mat <- table("Predictions" = predicted, Actual = data.test.cl)
conf.mat
