library(caret)
library(ggplot2)
library(randomForest)

setwd("~/Data/Coursera Practical Machine Learning")


## Read data from file. set "NA", "" and "#DIV/0!" as NAs
pmlTesting <- read.csv("pml-testing.csv", na.strings = c("NA", "", "#DIV/0!"))
pmlTraining<- read.csv("pml-training.csv", na.strings = c("NA", "", "#DIV/0!"))

## Create training / cross validation set
set.seed(12345)
inTrain <- createDataPartition(y=pmlTraining$classe, p=0.7, list=FALSE)
training <- pmlTraining[inTrain,]
testing <- pmlTraining[-inTrain,]

## Check NAs
colSums(is.na(training))/nrow(training)

## Remove column with more than 95% NAs
keepColumns <- colSums(is.na(training))/nrow(training) < 0.95
training <- training[,keepColumns]
testing <- testing[, keepColumns]
pmlTesting <- pmlTesting[, keepColumns]

## Remove user_name and cvtd_timestamp
training <- training[,-c(2,5)]
testing <- testing[,-c(2,5)]
pmlTesting <- pmlTesting[,-c(2,5)]

## random forest
modelRF <-randomForest(classe ~ ., data = training, ntree =200)
testing$RF <- predict(modelRF, testing)

## Check accuracy
confusionMatrix(testing$classe, testing$RF)

## Predict on test data
pmlTesting$RF <- predict(modelRF, pmlTesting)
