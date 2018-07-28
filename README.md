#  Getting and Cleaning Data - Course Project
##  Creating the data set

This is the Course Project for the Getting and Cleaning Data Coursera Course.

The R script, run_analysis.R, does the following:
      
1.  Downloads the dataset if it does not already exist in the working directory.
2.  Loads the activity lables and feature information.
3.  Loads both the train and test datasets, while keeping only the columns for mean or standard deviation.
4.  Loads the activity and subject data for each dataset, and merges those columns with the dataset
5.  Removes excess tables after they have been merged.
6.  Merges the two datasets.
7.  Converts the activity and subject columns into factors
8.  Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
9.  The file tidy.txt. was created by running the run_analysis.R script suing R version 3.5.1
(2018-07-02) on Mac High Sierra Version 10.13.6
10.  This script requires the reshape2 package (version 1.4.3 was used).
