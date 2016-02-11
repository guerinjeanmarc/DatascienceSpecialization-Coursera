library(dplyr)
library(reshape2)

## Load files
subject_test <- read.table("./test/subject_test.txt")
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_train <- read.table("./train/subject_train.txt")
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
features <- read.table("features.txt")
labels <- read.table("activity_labels.txt")

## Rename variable
names(subject_test) <- "subjects"
names(y_test) <- "labels"
names(X_test) <- features[,2]
names(X_test) <- sub("\\(\\)","",names(X_test))   ## removes () from names
names(X_test) <- sub("-","_",names(X_test))       ## replaces - by _
names(X_test) <- sub("-","_",names(X_test))
names(subject_train) <- "subjects"
names(y_train) <- "labels"
names(X_train) <- features[,2]
names(X_train) <- sub("\\(\\)","",names(X_train)) ## removes () from names
names(X_train) <- sub("-","_",names(X_train))     ## replaces - by _
names(X_train) <- sub("-","_",names(X_train))
names(labels) <- c("labels", "activity")

## Merge dataset
data_test <- cbind(subject_test, y_test, X_test)
data_train <- cbind(subject_train, y_train, X_train)
data <- rbind(data_test,data_train)


## Extracts only the measurements on the mean and standard deviation for each
## measurement. 
mean_col <- grep("mean" ,names(data))       ## finds column with "mean"
meanFreq_col <- grep("meanFreq", names(data)) ## finds columns with "meanFreq"
mean_col <- setdiff(mean_col, meanFreq_col)  ## removes columns with "meanFreq" 
std_col <- grep("std", names(data))         # finds columns with "std"

data <- data[,c(1,2,mean_col, std_col)]

## Create descriptive activity and subject names
data <- merge(data,labels)
##data$subjects <- as.factor(data$subjects)

## 5. From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.

data$bigfactor <- with(data, interaction(data$labels, data$subjects))
tidy_data <- data %>% group_by(bigfactor) %>% summarise_each(funs(mean))
tidy_data <- tidy_data[,2:69]
tidy_data <- melt(tidy_data,id.vars = c("labels","subjects"))
tidy_data$labels <- labels[,2][tidy_data$labels]
names(tidy_data)[1] <- "activity"

write.table(tidy_data, "tidy_data.txt", row.names = FALSE)

