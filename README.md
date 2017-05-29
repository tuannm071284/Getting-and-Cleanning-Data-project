## Getting and Cleaning Data - Course Project
This is the course project for the Getting and Cleaning Data Coursera course (delivered by John Hopskin Universty)
First of all, we need to download the data from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzip data into your working directory. A full description is available at the site where the data was obtained [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
The R script, run_analysis.R, does the followings:
1. Load data:
   -Load test dataset store in table names **test** 
    * read table from "UCI HAR Dataset/test/X_test.txt",  
    * read table from "UCI HAR Dataset/test/Y_test.txt"
    * read table from "UCI HAR Dataset/test/subject_test.txt"
    * Combine three by Columns and store in **test**
  - Load training dataset store in table names **train**
    * read table from "UCI HAR Dataset/train/X_train.txt",  
    * read table from "UCI HAR Dataset/train/Y_train.txt"
    * read table from "UCI HAR Dataset/train/subject_train.txt"
    * Combine three by Columns and store in **train**
  - Combine **test** and **train** by row into one data set called **raw_data_1**
2. Load activity labels and features:
  - Load the activity from "UCI HAR Dataset/activity_labels.txt" store in **activityLabels**.
  - Load features from "UCI HAR Dataset/features.txt" store in **features**. 
3. Filter out the data
  - Filter the Labels, we just need features which  measurements on the mean and standard deviation then store in **features_filtered**
  - Make a subset data of data with the first colume, the second colume and some features colume in **features_filtered**
  - Add colume name into data
4. "melt" data so that each row is a unique **subject-activity** combination and store in **melted_data**.
5. Use cast funtion to creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair. The result stored in data which name is **tidy_data**. 
6. Last step, we wrote the **tidy_data** into file name "**tidy.txt**".
