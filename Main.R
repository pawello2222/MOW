#Sources
source("DataLoader.R")

# Packages
library(tm)
library(stringr)
library(RTextTools)

# Load the data from the csv file
df <- loadData("~/Documents/Projekty/MOW/")

corpus <- Corpus(VectorSource(df$Text))

corpus = tm_map(corpus,removeNumbers)
corpus = tm_map(corpus,str_replace_all,pattern = "<.*?>", replacement =" ")
corpus = tm_map(corpus,str_replace_all,pattern ="\\=", replacement =" ")
corpus = tm_map(corpus,str_replace_all,pattern = "[[:punct:]]", replacement =" ")
corpus = tm_map(corpus,removeWords, words= stopwords("en"))
corpus = tm_map(corpus,tolower)
corpus = tm_map(corpus,stripWhitespace)
corpus = tm_map(corpus,stemDocument)

# Create dtm
dtm <- DocumentTermMatrix(corpus)

# Transform dtm to matrix to data frame - df is easier to work with
mat.df <- as.data.frame(data.matrix(dtm), stringsAsfactors = FALSE)

# Column bind category (known classification)
mat.df <- cbind(mat.df, df$Category)

# Change name of new column to "category"
colnames(mat.df)[ncol(mat.df)] <- "category"

# Split data by rownumber into two equal portions
train <- sample(nrow(mat.df), ceiling(nrow(mat.df) * .80))
test <- (1:nrow(mat.df))[- train]

# Isolate classifier
cl <- mat.df[, "category"]

# Create model data and remove "category"
modeldata <- mat.df[,!colnames(mat.df) %in% "category"]

# Create model: training set, test set, training set classifier
knn.pred <- knn(modeldata[train, ], modeldata[test, ], cl[train], 
                k = 1, l = 0, prob = FALSE, use.all = FALSE)

# Confusion matrix
conf.mat <- table("Predictions" = knn.pred, Actual = cl[test])
conf.mat

# Accuracy
(accuracy <- sum(diag(conf.mat))/length(test) * 100)

# Create data frame with test data and predicted category
df.pred <- cbind(knn.pred, modeldata[test, ])
#write.table(df.pred, file="output.csv", sep=";")
