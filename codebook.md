This codebook explains the information about the data processing that was done for the 
assignment for the "Getting and Cleaning Data" course


"run_analysis.R" will take the data from the UCIHAR Dataset and
processes it (details below). The UCIHAR Dataset is the described as
following from the source[1]:

Packages used: sqldf and reshape2

# run_analysis will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test dataframes to create a single data frame 
# 2. Clean the column names and activity descriptions
# 3. Create the final dataset by merging subject, X, Y with all observations 
# 4. Use descriptive activity names to name the activities in the data set
# 5. Calculate mean of each subject by activity and write the raw data to a file 
##########################################################################################################e 

Variable names and functions have been appropriately commented in the run_analysis.R code file.

Sources: [1]
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+
Smartphones [2] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier
Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on
Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.
International Workshop of Ambient Assisted Living (IWAAL 2012).
Vitoria-Gasteiz, Spain. Dec 2012
