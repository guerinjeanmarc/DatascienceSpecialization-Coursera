---
title: "Codebook template"
author: "Jean-Marc Guerin"
date: "23/11/2015"

---

## Project Description
This course project is from the class [Getting and Cleaning Data](https://www.coursera.org/course/getdata) .

##Study design and data processing

###Collection of the raw data
Data and descriptions are available here: ["Human Activity Recognition Using Smartphones" data set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

##Creating the tidy datafile

###Guide to create the tidy data file
1. Download the zip file from [this URL](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
2. Unzip the file.
3. Set your working directory inside the UCI HAR Dataset folder
4. Run the run_analysis.R script in R
5. It will create a tidy_data.txt file

###Cleaning of the data
Here is what the script performs:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Description of the variables in the tiny_data.txt file

11880 Observations of 4 variables
 
activity: 
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

subjects:
identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
 
 tBodyAcc_mean_X           tBodyAcc_mean_Y          
 tBodyAcc_mean_Z           tGravityAcc_mean_X       
 tGravityAcc_mean_Y        tGravityAcc_mean_Z       
 tBodyAccJerk_mean_X       tBodyAccJerk_mean_Y      
 tBodyAccJerk_mean_Z       tBodyGyro_mean_X         
 tBodyGyro_mean_Y          tBodyGyro_mean_Z         
 tBodyGyroJerk_mean_X      tBodyGyroJerk_mean_Y     
 tBodyGyroJerk_mean_Z      tBodyAccMag_mean         
 tGravityAccMag_mean       tBodyAccJerkMag_mean     
 tBodyGyroMag_mean         tBodyGyroJerkMag_mean    
 fBodyAcc_mean_X           fBodyAcc_mean_Y          
 fBodyAcc_mean_Z           fBodyAccJerk_mean_X      
 fBodyAccJerk_mean_Y       fBodyAccJerk_mean_Z      
 fBodyGyro_mean_X          fBodyGyro_mean_Y         
 fBodyGyro_mean_Z          fBodyAccMag_mean         
 fBodyBodyAccJerkMag_mean  fBodyBodyGyroMag_mean    
 fBodyBodyGyroJerkMag_mean tBodyAcc_std_X           
 tBodyAcc_std_Y            tBodyAcc_std_Z           
 tGravityAcc_std_X         tGravityAcc_std_Y        
 tGravityAcc_std_Z         tBodyAccJerk_std_X       
 tBodyAccJerk_std_Y        tBodyAccJerk_std_Z       
 tBodyGyro_std_X           tBodyGyro_std_Y          
 tBodyGyro_std_Z           tBodyGyroJerk_std_X      
 tBodyGyroJerk_std_Y       tBodyGyroJerk_std_Z      
 tBodyAccMag_std           tGravityAccMag_std       
 tBodyAccJerkMag_std       tBodyGyroMag_std         
 tBodyGyroJerkMag_std      fBodyAcc_std_X           
 fBodyAcc_std_Y            fBodyAcc_std_Z           
 fBodyAccJerk_std_X        fBodyAccJerk_std_Y       
 fBodyAccJerk_std_Z        fBodyGyro_std_X          
 fBodyGyro_std_Y           fBodyGyro_std_Z          
 fBodyAccMag_std           fBodyBodyAccJerkMag_std  
 fBodyBodyGyroMag_std      fBodyBodyGyroJerkMag_std

