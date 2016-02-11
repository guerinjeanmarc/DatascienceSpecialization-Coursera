---
title: "Prediction of activity from accelerometers"
author: "Jean-Marc Guerin"
date: "Feb 12, 2016"
output: html_document

---
This project is an assigment exercise for the [Practical Machine Learning](https://www.coursera.org/learn/practical-machine-learning) course on Coursera

# Background
Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement - a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, your goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. More information is available from the website here: http://groupware.les.inf.puc-rio.br/har (see the section on the Weight Lifting Exercise Dataset).

# Objective
The goal of the project is to predict the manner in which they did the exercise. This is the "classe" variable in the training set.

# Approach
1. Libraries
2. Load Data
3. Slice data for cross validation
4. Clean data
5. Train Random Forest model
6. Assess performance on validation set
7. Assess performance on test set


## Libraries
Load caret and random forest packages. 
```{r}
library(caret)
library(randomForest)
```
## Load Data
The files can be downloaded from the following links: [training set](https://eventing.coursera.org/api/redirectStrict/UuRKzkvR064fsKIYxg3ZlZwJAEYclUyoBlEsDfnfa-hoF1vaCq1GKBALBjIWz8qNR95U_huqda1qM3r5Jk5REA.sJpe4pp4h5r-2ZZSjkUPpA.tSiiz7F1YwNcbMgTD_eDfbScfcqGCiCaAx0rK-NGNdCBx9PpPmgfEuURsI99WFpYcSV7fC4fcKmyF7eroaJj_fnSabgPX9X09qhUrC1wTUP0HOER9b-1UbI7XEvCu-begDcO_lEC_hxJd29U8Qm8eAi1h5xTCfM9yh3zFa6bc6oqJ28WmNnVpa4VJCcOKsoIDWCdpLzGgvPgsovVIR7uwPdtkvzEbAAO5AdM8gFTUnQLU2YmGA9R0thVlP6vDDSJTJRImKSJ3isp5S0AoRho0FSYdXMiACzSqhkjWPBSdvfTSb75hJR_QMvu692sd4sKfPX5xXN7ecGyNvwh8voqXnZxCVG36_OUyR_rQWV1nQms-d9-q70gfa5wfnOlwcgmXsKlt8jhT-nKRpxXKZlXgg) and [test set](https://eventing.coursera.org/api/redirectStrict/K9PfQz53FCXUSLc-0kd6nETP_saykkjknPJ_VGAWtBfFagG7W97LrBD71w6l0jrr_fmlb2Onf-IwWNgSMh0x3g.pxS4SVYXtjrkzGuI0JdhZg.eS5iinJEMV6TnAGkLdPISK3SFo6aZpl1G6muxq1FKP-co3Vk8UXYzUIRzX4BNt7MIvkOgPcjLZK5d96yBDiifehlif7LNacO1h3ceC2lPWOJKi7jvyqVBlSTu7J7LlD_ShnLrMfh8Qd22RhWbDCNf15MDjz1Jp70hTZHnxpi2J7SgMz0BYwkVg4MEwxomEJUVPwNX7j87rifN5kbojDTIDp48o_RQ8uV52k2mEbdJXfy0YIHtvUMtcd9r0omkoWfTZsnZpBlNN80VCmYPJNijWihSR2xR8dPjvkgB6cyoVGbc_PIt15RMDZLBYjagcn8ZLxX5TgsZ1aX2gxgXEo1pzu7mFMPXpcxNBaChqrXznFTj3abvNXUa29E3Zm-n6gQN0kAGSJC2wAYb-gPjO28tA)
Reads data from csv file. From a first analysis, the file has a lot of missing values either set as "NA", "" or "#DIV/0!"
```{r}
pmlTesting <- read.csv("pml-testing.csv", na.strings = c("NA", "", "#DIV/0!"))
pmlTraining<- read.csv("pml-training.csv", na.strings = c("NA", "", "#DIV/0!"))
```

## Slice data for cross validation
Create training / cross validation set with 0.7/0.3 ratio
```{r}
set.seed(12345)
inTrain <- createDataPartition(y=pmlTraining$classe, p=0.7, list=FALSE)
training <- pmlTraining[inTrain,]
testing <- pmlTraining[-inTrain,]
```
## Clean Data
### Check for NAs
First we compute the ratio of NAs for each predictor
```{r}
colSums(is.na(training))/nrow(training)
```
A majority of predictor has more than 98% of NAs

### Remove predictors with more than 95% NAs
```{r}
keepColumns <- colSums(is.na(training))/nrow(training) < 0.95
training <- training[,keepColumns]
testing <- testing[, keepColumns]
```

### Remove non-usable predictors 
user_name and cvtd_timestamp give information on the user and the time of the experience, which should not be correlated to the classes we want to predict
```{r}
training <- training[,-c(2,5)]
testing <- testing[,-c(2,5)]
```

## Train Random Forest model
A random forest aglorithm is trained with 200 trees for a first prediction. We can refine its parameters or compare to other algorithm later, based on its accuracy.  
```{r}
modelRF <-randomForest(classe ~ ., data = training, ntree =200)
testing$RF <- predict(modelRF, testing)
```

## Assess performance on validation set
```{r}
confusionMatrix(testing$classe, testing$RF)
```
Overall statistics: All the rows have been perfectly classified! Accuracy is 1, out of sample error is 0. We can try to submit the test set.

## Assess performance on test set
```{r}
#pmlTesting$RF <- predict(modelRF, pmlTesting, type="class")
```
We were given 20 test cases to apply the algorithm. 100% of the predictions from this simple algorithm were right!


