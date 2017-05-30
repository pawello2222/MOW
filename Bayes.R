#Sources
#source("DataLoader.R")

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

cryptography = loadCategory(base_dir, "Cryptography")
electronics = loadCategory(base_dir, "Electronics")
medicine = loadCategory(base_dir, "Medicine")
space = loadCategory(base_dir, "Space")

test_data = rbind(
  c('safe lock guard data', 'Cryptography'),
  c('power cable electrcity', 'Electronics'),
  c('health cure vaccine', 'Medicine'),
  c('moon sun planet far away', 'Space')
)

data = rbind(cryptography, electronics, medicine, space, test_data)

matrix = create_matrix(data[,1], language="english", minDocFreq=3,
                       removeStopwords=TRUE, removeNumbers=TRUE, 
                       removePunctuation=TRUE, stripWhitespace=TRUE, 
                       toLower=TRUE, stemWords=TRUE) 

mat = as.matrix(matrix)

classifier = naiveBayes(mat[1:4000,], as.factor(data[1:4000, 2]) )

predicted = predict(classifier, mat[2000:2100,])
table(data[2000:2100, 2], predicted)
recall_accuracy(data[2000:2100, 2], predicted)