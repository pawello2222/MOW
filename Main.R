#Sources
source("DataLoader.R")
source("Bayes.R")
source("KNN.R")
source("SVM.R")

#Data
data <- loadData("~/Documents/Projekty/MOW/", 100)

#Classifiers
#results <- classify_bayes(data, 390)
#results <- classify_knn(data, 390)
#results <- classify_svm(data, 390)
results