##########################################################################################################
## File Name: run_analysis.r
## CourseName: Coursera Getting and Cleaning Data Course Project
## Submission Date: 2014-06-22
## Author: Rahul Sharma

#  File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test dataframes to create a single data frame 
# 2. Clean the column names and activity descriptions
# 3. Create the final dataset by merging subject, X, Y with all observations 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Calculate mean of each subject by activity and write the raw data to a file 

# Path for the data files needs to be updated prior to running in any other environment
##########################################################################################################
#Load all Libraries needed to run the program
library(sqldf)

library(reshape2)

# Clean up workspace
rm(list=ls())

# 1. Merge the training and the test sets to create one data set.
# Path for the data files needs to be updated prior to running in any other environment
# Load test and training data
getwd()
setwd("/Users/Rahul/Documents/Coursera/Signature Track Data Science/03_Getting and Cleaning Data/Week 3/UCI HAR Dataset//")

# Read in the Train and Test data from files
X_Test <- read.table("./test/X_test.txt")
Y_Test <- read.table("./test/y_test.txt")
X_Train <- read.table("./train/X_train.txt")
Y_Train <- read.table("./train/y_train.txt")

#Read the files with features, activity labels
features = read.table("./features.txt", sep=""); features = features[,2];
activityLabels = read.table("./activity_labels.txt", sep=""); 

subject_Train = read.table('./train/subject_train.txt',header=FALSE); #imports subject_train.txt
subject_Test = read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt

#Merge training and test set 
X = rbind(X_Train,X_Test) 
Y = rbind(Y_Train,Y_Test)
subject=rbind(subject_Train,subject_Test)

#2. Clean the variable and column names


#Assign easily comprehensible column names 
names(X) <- features
#Select only columns with measurements on the mean and std_dev for each measurement
#Eliminate column names with meanFreq in them by using [^F] option after grep

#logColumns <- X[, grepl("std|mean[^F]", colnames(X))]
logCol<-grepl("std|mean[^F]",colnames(X))
X_mean_stdev<-X[,logCol]

colnames(Y) = "activityId";
colnames(subject)  = "subjectId";
names(activityLabels)<-c("activity_ID","activity_Desc")

#Join Y to activity_Label dataframe to obtain activity label for each activity_ID
Y<-sqldf("select a.activityID,b.activity_Desc from Y a left outer join activityLabels b on a.activityID=b.activity_ID")
# merge activity lables & activity codes

#3.  Create the final dataset by merging subject, X, Y with all observations
df_all_obs=cbind(subject,X_mean_stdev,Y)

#4. Clean the column names of the smaller dataframe with mean and std dev values
# lower case all column names
colnames(df_all_obs) <- tolower(colnames(df_all_obs))

# remove dash from all column names
colnames(df_all_obs) <- gsub("\\-", "", colnames(df_all_obs))

# remove (  from all column names
colnames(df_all_obs) <- gsub("\\(", "", colnames(df_all_obs))

# remove ) from all column names
colnames(df_all_obs) <- gsub("\\)", "", colnames(df_all_obs))

# Replace std with stddev
colnames(df_all_obs) <- gsub("std", "stddev", colnames(df_all_obs))

# Replace mag with magnitude
colnames(df_all_obs) <- gsub("mag","magnitude", colnames(df_all_obs))

# Replace t with time
colnames(df_all_obs) <- gsub("^(t)","time", colnames(df_all_obs))

# Replace f with freq
colnames(df_all_obs) <- gsub("^(f)","freq", colnames(df_all_obs))


#4. Calculate mean of each subject by activity and write the raw data to a file 
write.table(df_all_obs, "./tidydata.txt")

#Remove activityid before taking the mean
mergedData <- within(df_all_obs, rm(activityid))

# determine means
meanData <-melt(mergedData, id=c("subjectid", "activity_desc"))
meanTidyData<-dcast(meanData, subjectid + activity_desc ~ variable, fun.aggregate=mean)


# write meanTidyData to file
write.table(meanTidyData, "./meantidydata.txt")

#View the dataframe where mean of each subject by activity is stored 

View(meanTidyData)

