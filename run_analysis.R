##  Getting and Cleaning Data Course Project

library(reshape2)

#  Download zip file containing data.
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipUrl, destfile = "UCI HAR Dataset.zip", method = "curl")

#  Unzip file.
dataset <- unzip("UCI HAR Dataset.zip")

#  Load activity labels + features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

#  Keep only the mean and standard deviation
kept <- grep(".*mean.*|.*std.*", features[,2])
kept.names <- features[kept,2]
kept.names = gsub('-mean', 'Mean', kept.names)
kept.names = gsub('-std', 'Std', kept.names)
kept.names <- gsub('[-()]', '', kept.names)

#  Read Train data and Test data
train <- read.table("UCI HAR Dataset/train/X_train.txt")[kept]
trainA <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainS <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainS, trainA, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[kept]
testA <- read.table("UCI HAR Dataset/test/Y_test.txt")
testS <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testS, testA, test)

#  Clean up since merged and for memory space
rm(trainA, trainS, testA, testS)

#  Merge the training and the test sets to create one data set and add lables
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", kept.names)

#  Turn the Activities and Subjects into Factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], 
                           labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

#  Write to tidy.txt file
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
