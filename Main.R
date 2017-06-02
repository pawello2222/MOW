### Config
# Run installation script
#source(Install.R)
# Fix errors: in line 42 change 'Acronym' to 'acronym' and save
#trace("create_matrix", edit=T)

### Sources
source("Helpers.R")
source("Bayes.R")
source("KNN.R")
source("SVM.R")

### Data
# Category size should be in range <0...1000>
category_size <- 100
# Training set size should be in range <0...4*category_size>
train_size <- 390

# Loading data
data <- loadData("~/Documents/Projekty/MOW/", category_size)
data_length <- length(data[,1])
col_names <- unique(data[,2])

# Bayes classifier
predictions <- classify_bayes(data, train_size)
results.bayes <- table("Predictions" = predictions,
                       "Actual" = data[(train_size+1):data_length,2])
print("Bayes:")
print(results.bayes)

# KNN classifier
predictions <- classify_knn(data, train_size)
results.knn <- table("Predictions" = predictions,
                     "Actual" = data[(train_size+1):data_length,2])
print("KNN:")
print(results.knn)

# SVM classifier
predictions <- classify_svm(data, train_size)
results.svm <- table("Predictions" = predictions[,"SVM_LABEL"],
                  "Actual" = data[(train_size+1):data_length,2])
print("SVM:")
print(results.svm)
