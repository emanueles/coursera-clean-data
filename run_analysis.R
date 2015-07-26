# This script does the following:
# Search for the  "UCI HAR Dataset" folder in the current directory, and if it
# does not exist, will download the zip file (if it doesn't exist) and extract 
# it to the current directory. 
# If you named the data folder differently, please change the 'folderName' 
# variable in line 22 below.

# Then it will do what was required in the course project description:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

library(reshape2)

## --- Change this variables according to your system ##
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "samsung_dataset.zip"
folderName <- "UCI HAR Dataset"
## --- end of configuration

activityFile <- paste(folderName,"activity_labels.txt", sep = "/")
featureFile <- paste(folderName,"features.txt", sep = "/")

# Download and unzip the dataset, if it doesn't exist:
if (!file.exists(folderName)){
    if (!file.exists(fileName)){
        download.file(fileURL, fileName, method="curl")
    }
    unzip(fileName)
}  

# Load activity labels and features
activityLabels <- read.table(activityFile)
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table(featureFile)
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation using regular expressions
# Anything that has mean or std in the name will be included
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]

# Using camel case notation and removing parenthesis from the names, so they are
# more legible
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

# Loading the only the wanted features from the datasets
# Training data first
train <- read.table(paste(folderName, "train", "X_train.txt", sep="/"))[featuresWanted]
trainActivities <- read.table(paste(folderName, "train","Y_train.txt",sep="/"))
trainSubjects <- read.table(paste(folderName, "train","subject_train.txt", sep="/"))
train <- cbind(trainSubjects, trainActivities, train)

#Then testing data
test <- read.table(paste(folderName, "test","X_test.txt", sep="/"))[featuresWanted]
testActivities <- read.table(paste(folderName, "test","Y_test.txt", sep="/"))
testSubjects <- read.table(paste(folderName, "test", "subject_test.txt", sep="/"))
test <- cbind(testSubjects, testActivities, test)

# merging datasets
allData <- rbind(train, test)

#adding labels
colnames(allData) <- c("subject", "activity", featuresWanted.names)

# turn activities and subjects into factors so we can aggregate the data
# (computing means) later
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

# Melting data by subject + activity
allData.molten <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.molten, subject + activity ~ variable, mean)

# writing the data
write.table(allData.mean, "tidyData.txt", row.names = FALSE, quote = FALSE)
