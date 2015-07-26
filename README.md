# Getting and Cleaning Data Course Project

This is the course project for Coursera's **Getting and Cleaning Data ** course.

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The data we were given to work with represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project is available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## Scripts
For this project I've created 2 scripts. They are described below:

### run_analysis.R
*Requirements: the **reshape2** library.*

 It does the following:

1. Downloads the dataset if it does not already exist in the working directory (see comments in the beginning of the script for customization)
2. Loads the activity and feature labels
3. Loads both the training and test datasets, keeping only those variables which reflect a mean or standard deviation
4. Loads the activity and subject data for the train and test datasets, adding those columns to the datasets
5. Merges the two datasets into a single one
6. Converts the activity and subject columns into factors
7. Finally creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

```
> setwd([the directory where run_analysis.R is located])
> source('run_analysis.R')

```


### load_tidy_data.R

As recommended on the very helpful [thread](https://class.coursera.org/getdata-030/forum/thread?thread_id=37) by David Hood, I am also providing a script to load the data.

```
> source('load_tidy_data.R')
```
Then it will display the tidy data.

## The tidy data
According to [Hadley Wickham's Tidy Data paper](http://www.jstatsoft.org/v59/i10/paper):

> Tidy datasets are easy to manipulate, model and visualize, and have a specific structure: each variable is a column, each observation is a row, and each type of observational unit is a table.

I've tried to follow the principles on the paper to build the tidy data set for this course project. Each row on the dataset is an observation of subject + activity type measurements. This means that every combination of subject and activity type were measured, a completely crossed design.

If we look at the first few lines and columns of the tidy data:

```
> data[1:2,1:4]
  subject         activity tBodyAccMeanX tBodyAccMeanY
1       1          WALKING     0.2773308   -0.01738382
2       1 WALKING_UPSTAIRS     0.2554617   -0.02395315
```

We can see that it uses descriptive activity names to name the activities in the data set and appropriately labels the data set with descriptive variable names, such as tBodyAccMeanX, tBodyAccMeanY, etc.

## The code book for the tidy data is described in the CodeBook.md file.

